import 'package:med_core/src/util/value_equality.dart';
import 'package:meta/meta.dart';

/// An axis-aligned bounding box in page or frame pixels.
@immutable
final class OcrBox {
  /// Creates a box.
  const OcrBox(this.left, this.top, this.width, this.height);

  /// A zero box, for text with no geometry (typed input, fixtures).
  static const zero = OcrBox(0, 0, 0, 0);

  /// Distance from the start edge.
  final double left;

  /// Distance from the top edge.
  final double top;

  /// Width.
  final double width;

  /// Height.
  final double height;

  @override
  bool operator ==(Object other) =>
      other is OcrBox &&
      other.left == left &&
      other.top == top &&
      other.width == width &&
      other.height == height;

  @override
  int get hashCode => Object.hash(left, top, width, height);
}

/// One recognized line of text, in page / reading order.
@immutable
final class OcrLine {
  /// Creates a line.
  const OcrLine(this.text, {this.box = OcrBox.zero, this.page = 0});

  /// Recognized text.
  final String text;

  /// Where the line sits on the page.
  final OcrBox box;

  /// Zero-based page index.
  final int page;

  @override
  bool operator ==(Object other) =>
      other is OcrLine &&
      other.text == text &&
      other.box == box &&
      other.page == page;

  @override
  int get hashCode => Object.hash(text, box, page);

  @override
  String toString() => 'OcrLine($text)';
}

/// The OCR result for one camera frame.
@immutable
final class OcrFrame {
  /// Creates a frame captured at [tMs] milliseconds.
  const OcrFrame(this.lines, {this.tMs = 0});

  /// Recognized lines.
  final List<OcrLine> lines;

  /// Capture time in milliseconds from the start of the scan.
  final int tMs;

  @override
  bool operator ==(Object other) =>
      other is OcrFrame && listEquals(other.lines, lines) && other.tMs == tMs;

  @override
  int get hashCode => Object.hash(Object.hashAll(lines), tMs);
}
