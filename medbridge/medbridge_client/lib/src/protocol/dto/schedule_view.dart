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
import '../dose_event.dart' as _i1bzuh8d;
import '../dose_schedule.dart' as _ipkfbn8g;
import '../plan_item_row.dart' as _im1sjkto;

abstract class ScheduleView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ScheduleView._({
    required this.schedule,
    required this.item,
    required this.events,
  });

  factory ScheduleView({
    required _ipkfbn8g.DoseSchedule schedule,
    required _im1sjkto.PlanItemRow item,
    required List<_i1bzuh8d.DoseEvent> events,
  }) = _ScheduleViewImpl;

  factory ScheduleView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScheduleView(
      schedule: _iw3s9cgw.Protocol().deserialize<_ipkfbn8g.DoseSchedule>(
        jsonSerialization['schedule'],
      ),
      item: _iw3s9cgw.Protocol().deserialize<_im1sjkto.PlanItemRow>(
        jsonSerialization['item'],
      ),
      events: _iw3s9cgw.Protocol().deserialize<List<_i1bzuh8d.DoseEvent>>(
        jsonSerialization['events'],
      ),
    );
  }

  _ipkfbn8g.DoseSchedule schedule;

  _im1sjkto.PlanItemRow item;

  List<_i1bzuh8d.DoseEvent> events;

  /// Returns a shallow copy of this [ScheduleView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ScheduleView copyWith({
    _ipkfbn8g.DoseSchedule? schedule,
    _im1sjkto.PlanItemRow? item,
    List<_i1bzuh8d.DoseEvent>? events,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScheduleView',
      'schedule': schedule.toJson(),
      'item': item.toJson(),
      'events': events.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScheduleView',
      'schedule': schedule.toJsonForProtocol(),
      'item': item.toJsonForProtocol(),
      'events': events.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ScheduleViewImpl extends ScheduleView {
  _ScheduleViewImpl({
    required _ipkfbn8g.DoseSchedule schedule,
    required _im1sjkto.PlanItemRow item,
    required List<_i1bzuh8d.DoseEvent> events,
  }) : super._(
         schedule: schedule,
         item: item,
         events: events,
       );

  /// Returns a shallow copy of this [ScheduleView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ScheduleView copyWith({
    _ipkfbn8g.DoseSchedule? schedule,
    _im1sjkto.PlanItemRow? item,
    List<_i1bzuh8d.DoseEvent>? events,
  }) {
    return ScheduleView(
      schedule: schedule ?? this.schedule.copyWith(),
      item: item ?? this.item.copyWith(),
      events: events ?? this.events.map((e0) => e0.copyWith()).toList(),
    );
  }
}
