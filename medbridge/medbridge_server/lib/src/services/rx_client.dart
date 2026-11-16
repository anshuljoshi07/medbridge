import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:med_core/med_core.dart' as core;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Token bucket: at most [ratePerSecond] calls per second (RxNav's limit is
/// 20/s).
final class TokenBucket {
  /// Creates a bucket refilled at [ratePerSecond].
  TokenBucket(this.ratePerSecond) : _tokens = ratePerSecond.toDouble();

  /// Refill rate and capacity.
  final int ratePerSecond;
  double _tokens;
  DateTime _last = DateTime.now();

  /// Waits until a token is available, then takes it.
  Future<void> take() async {
    while (true) {
      final now = DateTime.now();
      final elapsed = now.difference(_last).inMicroseconds / 1e6;
      _last = now;
      _tokens = (_tokens + elapsed * ratePerSecond).clamp(
        0,
        ratePerSecond * 1.0,
      );
      if (_tokens >= 1) {
        _tokens -= 1;
        return;
      }
      await Future<void>.delayed(
        Duration(milliseconds: (1000 / ratePerSecond).ceil()),
      );
    }
  }
}

/// RxNav / RxClass proxy with a 30-day [RxCache] (B5 step 5).
abstract final class RxClient {
  static const _base = 'https://rxnav.nlm.nih.gov/REST';
  static const _ttl = Duration(days: 30);

  /// Shared limiter for every outbound RxNav call.
  static final bucket = TokenBucket(20);

  /// HTTP transport; replaced in tests.
  static http.Client httpClient = http.Client();

  /// RxCUIs for an NDC as printed or scanned. Each 11-digit candidate is
  /// resolved; more than one hit means Unknown + confirm on the client.
  static Future<List<RxHit>> byNdc(Session session, String raw) async {
    final hits = <RxHit>[];
    for (final ndc in core.ndc11Candidates(raw)) {
      final json = await _get(
        session,
        'ndc:$ndc',
        'ndc',
        '/rxcui.json?idtype=NDC&id=$ndc',
      );
      final ids = (json['idGroup'] as Map?)?['rxnormId'] as List? ?? const [];
      for (final id in ids) {
        hits.add(RxHit(rxcui: '$id', name: ndc, tty: 'NDC'));
      }
    }
    return hits;
  }

  /// Approximate name match (`/approximateTerm`).
  static Future<List<RxHit>> approximate(Session session, String term) async {
    final q = Uri.encodeQueryComponent(term.trim().toLowerCase());
    final json = await _get(
      session,
      'approx:$q',
      'approximate',
      '/approximateTerm.json?term=$q&maxEntries=5',
    );
    final list =
        (json['approximateGroup'] as Map?)?['candidate'] as List? ?? const [];
    return [
      for (final c in list.cast<Map<String, Object?>>())
        RxHit(
          rxcui: '${c['rxcui']}',
          name: '${c['name'] ?? ''}',
          tty: 'APPROX',
          score: double.tryParse('${c['score']}'),
        ),
    ];
  }

  /// ATC level-4 class ids for an RxCUI (RxClass).
  static Future<List<String>> classesFor(Session session, String rxcui) async {
    final json = await _get(
      session,
      'atc:$rxcui',
      'classes',
      '/rxclass/class/byRxcui.json?rxcui=$rxcui&relaSource=ATC',
    );
    final infos =
        (json['rxclassDrugInfoList'] as Map?)?['rxclassDrugInfo'] as List? ??
        const [];
    final out = <String>{};
    for (final info in infos.cast<Map<String, Object?>>()) {
      final item = info['rxclassMinConceptItem'] as Map?;
      final id = '${item?['classId'] ?? ''}';
      if (id.length == 5) out.add(id);
    }
    return out.toList()..sort();
  }

  static Future<Map<String, Object?>> _get(
    Session session,
    String key,
    String kind,
    String path,
  ) async {
    final cached = await RxCache.db.findFirstRow(
      session,
      where: (t) => t.key.equals(key),
    );
    final now = DateTime.now().toUtc();
    if (cached != null && now.difference(cached.fetchedAt) < _ttl) {
      return (jsonDecode(cached.json) as Map).cast<String, Object?>();
    }
    await bucket.take();
    final res = await httpClient
        .get(Uri.parse('$_base$path'))
        .timeout(const Duration(seconds: 10));
    if (res.statusCode != 200) return const {};
    final body = res.body;
    final row = RxCache(key: key, kind: kind, json: body, fetchedAt: now);
    if (cached == null) {
      await RxCache.db.insertRow(session, row);
    } else {
      await RxCache.db.updateRow(session, row.copyWith(id: cached.id));
    }
    return (jsonDecode(body) as Map).cast<String, Object?>();
  }
}
