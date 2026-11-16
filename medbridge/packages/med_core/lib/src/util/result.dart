import 'package:meta/meta.dart';

/// The outcome of a recoverable operation: an [Ok] value or an [Err] failure.
///
/// Switch exhaustively; never throw for expected failures.
@immutable
sealed class Result<T, F> {
  const Result();
}

/// A successful [Result] carrying [value].
final class Ok<T, F> extends Result<T, F> {
  /// Wraps [value].
  const Ok(this.value);

  /// The success value.
  final T value;

  @override
  bool operator ==(Object other) => other is Ok<T, F> && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Ok($value)';
}

/// A failed [Result] carrying [failure].
final class Err<T, F> extends Result<T, F> {
  /// Wraps [failure].
  const Err(this.failure);

  /// The failure value.
  final F failure;

  @override
  bool operator ==(Object other) =>
      other is Err<T, F> && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;

  @override
  String toString() => 'Err($failure)';
}
