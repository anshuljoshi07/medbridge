import 'package:med_core/src/parse/text_similarity.dart';
import 'package:meta/meta.dart';

/// One drug name from RxNorm's prescribable subset.
@immutable
final class LexEntry {
  /// Creates an entry. [name] and [ings] are lower-case.
  const LexEntry({
    required this.rxcui,
    required this.tty,
    required this.name,
    required this.ings,
    this.atc4 = const {},
  });

  /// RxNorm concept id.
  final String rxcui;

  /// Term type: IN, MIN, BN, or PLAN for closed-set plan entries.
  final String tty;

  /// Lower-case name.
  final String name;

  /// Lower-case ingredient names.
  final Set<String> ings;

  /// ATC level-4 class ids.
  final Set<String> atc4;

  @override
  String toString() => 'LexEntry($tty $name)';
}

/// A scored lexicon hit.
typedef LexMatch = ({LexEntry entry, double score});

/// Fuzzy drug-name lookup: trigram retrieval, then edit-distance scoring.
final class Lexicon {
  /// Builds the trigram index over [entries].
  Lexicon(List<LexEntry> entries) : _entries = List.unmodifiable(entries) {
    for (var i = 0; i < _entries.length; i++) {
      for (final g in trigrams(_entries[i].name)) {
        (_index[g] ??= []).add(i);
      }
    }
  }

  /// Parses `assets/lexicon.tsv` (rxcui, tty, name, ings, atc4). Lines that
  /// start with `#` or are malformed are skipped.
  factory Lexicon.fromTsv(String tsv) => Lexicon([
    for (final line in tsv.split('\n'))
      if (line.isNotEmpty && !line.startsWith('#')) ?_entryFromTsv(line),
  ]);

  final List<LexEntry> _entries;
  final Map<String, List<int>> _index = {};

  /// All entries.
  List<LexEntry> get entries => _entries;

  /// The best [limit] entries for [query], highest score first. Total.
  List<LexMatch> match(String query, {int limit = 5}) {
    final q = normalizeName(query);
    if (q.length < 3) return const [];
    final shared = <int, int>{};
    for (final g in trigrams(q)) {
      for (final i in _index[g] ?? const <int>[]) {
        shared[i] = (shared[i] ?? 0) + 1;
      }
    }
    final pool = shared.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final scored = [
      for (final e in pool.take(60))
        (
          entry: _entries[e.key],
          score: nameSimilarity(q, _entries[e.key].name),
        ),
    ]..sort(_byScore);
    return scored.take(limit).toList();
  }

  /// The best matches for any 1–3 word window of [line]: finds a drug name
  /// embedded in a longer OCR line. One hit per entry, highest first.
  List<LexMatch> findInLine(String line, {int limit = 5}) {
    final normalized = normalizeName(line);
    final cleaned = deconfuseOcr(normalized);
    if (cleaned != normalized) {
      return _mergeHits([
        ..._findWindows(normalized.split(' ')),
        ..._findWindows(cleaned.split(' ')),
      ], limit);
    }
    return _mergeHits(_findWindows(normalized.split(' ')), limit);
  }

  List<LexMatch> _findWindows(List<String> words) {
    final best = <String, LexMatch>{};
    for (var n = 3; n >= 1; n--) {
      for (var i = 0; i + n <= words.length; i++) {
        final window = words.sublist(i, i + n).join(' ');
        for (final m in match(window, limit: 3)) {
          final key = '${m.entry.tty}:${m.entry.name}';
          if ((best[key]?.score ?? -1) < m.score) best[key] = m;
        }
      }
    }
    return best.values.toList();
  }
}

List<LexMatch> _mergeHits(List<LexMatch> hits, int limit) {
  final best = <String, LexMatch>{};
  for (final m in hits) {
    final key = '${m.entry.tty}:${m.entry.name}';
    if ((best[key]?.score ?? -1) < m.score) best[key] = m;
  }
  return (best.values.toList()..sort(_byScore)).take(limit).toList();
}

int _byScore(LexMatch a, LexMatch b) {
  final c = b.score.compareTo(a.score);
  return c != 0 ? c : a.entry.name.compareTo(b.entry.name);
}

LexEntry? _entryFromTsv(String line) {
  final f = line.split('\t');
  if (f.length < 4) return null;
  Set<String> parts(String s) => {
    for (final p in s.split('|'))
      if (p.isNotEmpty) p,
  };
  return LexEntry(
    rxcui: f[0],
    tty: f[1],
    name: f[2].toLowerCase(),
    ings: parts(f[3]),
    atc4: f.length > 4 ? parts(f[4]) : const {},
  );
}
