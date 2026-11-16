/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

abstract class RxHit
    implements _is.SerializableModel, _is.ProtocolSerialization {
  RxHit._({
    required this.rxcui,
    required this.name,
    required this.tty,
    this.score,
  });

  factory RxHit({
    required String rxcui,
    required String name,
    required String tty,
    double? score,
  }) = _RxHitImpl;

  factory RxHit.fromJson(Map<String, dynamic> jsonSerialization) {
    return RxHit(
      rxcui: jsonSerialization['rxcui'] as String,
      name: jsonSerialization['name'] as String,
      tty: jsonSerialization['tty'] as String,
      score: (jsonSerialization['score'] as num?)?.toDouble(),
    );
  }

  String rxcui;

  String name;

  String tty;

  double? score;

  /// Returns a shallow copy of this [RxHit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RxHit copyWith({
    String? rxcui,
    String? name,
    String? tty,
    double? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RxHit',
      'rxcui': rxcui,
      'name': name,
      'tty': tty,
      if (score != null) 'score': score,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RxHit',
      'rxcui': rxcui,
      'name': name,
      'tty': tty,
      if (score != null) 'score': score,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RxHitImpl extends RxHit {
  _RxHitImpl({
    required String rxcui,
    required String name,
    required String tty,
    double? score,
  }) : super._(
         rxcui: rxcui,
         name: name,
         tty: tty,
         score: score,
       );

  /// Returns a shallow copy of this [RxHit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RxHit copyWith({
    String? rxcui,
    String? name,
    String? tty,
    Object? score = _Undefined,
  }) {
    return RxHit(
      rxcui: rxcui ?? this.rxcui,
      name: name ?? this.name,
      tty: tty ?? this.tty,
      score: score is double? ? score : this.score,
    );
  }
}
