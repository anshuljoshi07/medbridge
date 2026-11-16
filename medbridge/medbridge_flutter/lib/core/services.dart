import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:med_core/med_core.dart';

/// Read-aloud (F8). Reads plain-language text only, never abbreviations.
abstract interface class TtsService {
  Future<void> speak(String text, Lang lang, double rate);
  Future<void> stop();
}

/// Platform TTS (works offline; respects the requested rate).
class FlutterTtsService implements TtsService {
  final _tts = FlutterTts();

  /// Pronunciation overrides for drug names (F8).
  static const pronunciations = {
    'metoprolol': 'meh-TOE-pro-lol',
    'atorvastatin': 'a-TOR-va-stat-in',
    'losartan': 'low-SAR-tan',
    'lisinopril': 'lyse-IN-oh-pril',
  };

  @override
  Future<void> speak(String text, Lang lang, double rate) async {
    var spoken = text;
    pronunciations.forEach((k, v) => spoken = spoken.replaceAll(k, v));
    await _tts.setLanguage(lang == Lang.es ? 'es-US' : 'en-US');
    await _tts.setSpeechRate(rate);
    await _tts.speak(spoken);
  }

  @override
  Future<void> stop() => _tts.stop();
}

final ttsProvider = Provider<TtsService>((ref) => FlutterTtsService());

/// Haptics (A13.5): tick on capture, success on Taken, heavy on red. Stays
/// on under reduced motion.
abstract interface class HapticsService {
  Future<void> tick();
  Future<void> success();
  Future<void> warning();
}

class PlatformHaptics implements HapticsService {
  const PlatformHaptics();
  @override
  Future<void> tick() => HapticFeedback.selectionClick();
  @override
  Future<void> success() => HapticFeedback.lightImpact();
  @override
  Future<void> warning() => HapticFeedback.heavyImpact();
}

final hapticsProvider = Provider<HapticsService>((ref) => const PlatformHaptics());
