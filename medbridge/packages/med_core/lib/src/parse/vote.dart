import 'package:med_core/src/parse/ocr_types.dart';
import 'package:med_core/src/parse/text_similarity.dart';

/// Consensus text from several frames of a rotating bottle.
typedef VoteResult = ({List<String> lines, int frames});

/// Merges tokens across [frames] by majority vote, independent of position
/// (A7.2): curvature moves text around between frames, so tokens are voted
/// on by spelling, not location.
///
/// Near-identical spellings (edit distance ≤ 1 for tokens of 5+ chars) are
/// clustered, so OCR noise in one frame is outvoted by the others. A token
/// survives if it appears in at least half the frames (and in 2+ frames when
/// there are 3 or more). Lines keep their reading order; duplicates collapse.
VoteResult voteFrames(List<OcrFrame> frames) {
  if (frames.isEmpty) return (lines: const [], frames: 0);
  final clusters = <_Cluster>[];
  _Cluster clusterFor(String tok) {
    for (final c in clusters) {
      if (c.accepts(tok)) return c;
    }
    final c = _Cluster(tok);
    clusters.add(c);
    return c;
  }

  final tokenized = [
    for (var f = 0; f < frames.length; f++)
      [
        for (final line in frames[f].lines)
          [
            for (final tok in _tokens(line.text))
              (tok, clusterFor(tok)..see(tok, f)),
          ],
      ],
  ];
  final n = frames.length;
  final needed = n >= 3 ? ((n + 1) ~/ 2).clamp(2, n) : 1;
  final out = <String>[];
  for (final frame in tokenized) {
    for (final line in frame) {
      final kept = [
        for (final (_, c) in line)
          if (c.frameCount >= needed) c.best,
      ];
      final text = kept.join(' ');
      if (text.isNotEmpty && !out.contains(text)) out.add(text);
    }
  }
  return (lines: out, frames: n);
}

List<String> _tokens(String s) => s
    .toLowerCase()
    .split(RegExp(r'\s+'))
    .map((t) => t.replaceAll(RegExp(r'^[^\w.½/]+|[^\w.½/%]+$'), ''))
    .where((t) => t.isNotEmpty)
    .toList();

class _Cluster {
  _Cluster(String first) : _rep = first;

  final String _rep;
  final Map<String, int> _spellings = {};
  final Set<int> _frames = {};

  bool accepts(String tok) =>
      tok == _rep ||
      (tok.length >= 5 &&
          _rep.length >= 5 &&
          !_isNumeric(tok) &&
          editDistance(tok, _rep) <= 1);

  void see(String tok, int frame) {
    _spellings[tok] = (_spellings[tok] ?? 0) + 1;
    _frames.add(frame);
  }

  int get frameCount => _frames.length;

  /// The most frequent spelling; ties break alphabetically for determinism.
  String get best {
    final e = _spellings.entries.toList()
      ..sort((a, b) {
        final c = b.value.compareTo(a.value);
        return c != 0 ? c : a.key.compareTo(b.key);
      });
    return e.first.key;
  }

  static bool _isNumeric(String s) => RegExp(r'\d').hasMatch(s);
}
