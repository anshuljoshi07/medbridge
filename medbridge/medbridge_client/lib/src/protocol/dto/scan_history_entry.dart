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
import 'package:medbridge_client/src/protocol/protocol.dart' as _iw3s9cgw;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../bottle_scan.dart' as _i18mnjul;
import '../recon_row.dart' as _izapb14s;

abstract class ScanHistoryEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ScanHistoryEntry._({
    required this.scan,
    required this.recon,
  });

  factory ScanHistoryEntry({
    required _i18mnjul.BottleScan scan,
    required _izapb14s.ReconRow recon,
  }) = _ScanHistoryEntryImpl;

  factory ScanHistoryEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScanHistoryEntry(
      scan: _iw3s9cgw.Protocol().deserialize<_i18mnjul.BottleScan>(
        jsonSerialization['scan'],
      ),
      recon: _iw3s9cgw.Protocol().deserialize<_izapb14s.ReconRow>(
        jsonSerialization['recon'],
      ),
    );
  }

  _i18mnjul.BottleScan scan;

  _izapb14s.ReconRow recon;

  /// Returns a shallow copy of this [ScanHistoryEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ScanHistoryEntry copyWith({
    _i18mnjul.BottleScan? scan,
    _izapb14s.ReconRow? recon,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScanHistoryEntry',
      'scan': scan.toJson(),
      'recon': recon.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScanHistoryEntry',
      'scan': scan.toJsonForProtocol(),
      'recon': recon.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ScanHistoryEntryImpl extends ScanHistoryEntry {
  _ScanHistoryEntryImpl({
    required _i18mnjul.BottleScan scan,
    required _izapb14s.ReconRow recon,
  }) : super._(
         scan: scan,
         recon: recon,
       );

  /// Returns a shallow copy of this [ScanHistoryEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ScanHistoryEntry copyWith({
    _i18mnjul.BottleScan? scan,
    _izapb14s.ReconRow? recon,
  }) {
    return ScanHistoryEntry(
      scan: scan ?? this.scan.copyWith(),
      recon: recon ?? this.recon.copyWith(),
    );
  }
}
