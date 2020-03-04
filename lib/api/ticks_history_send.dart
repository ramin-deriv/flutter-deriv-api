/// Autogenerated from flutter_deriv_api|lib/api/ticks_history_send.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'request.dart';

part 'ticks_history_send.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class TicksHistoryRequest extends Request {
  ///
  TicksHistoryRequest(
      {this.adjustStartTime,
      this.count,
      this.end,
      this.granularity,
      this.start,
      this.style,
      this.subscribe,
      this.ticksHistory,
      int reqId,
      Map<String, dynamic> passthrough})
      : super(reqId: reqId, passthrough: passthrough);

  ///
  factory TicksHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$TicksHistoryRequestFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$TicksHistoryRequestToJson(this);

  // Properties
  /// [Optional] 1 - if the market is closed at the end time, or license limit is before end time, adjust interval backwards to compensate.
  int adjustStartTime;

  /// [Optional] An upper limit on ticks to receive.
  int count;

  /// Epoch value representing the latest boundary of the returned ticks. If `latest` is specified, this will be the latest available timestamp.
  String end;

  /// [Optional] Only applicable for style: `candles`. Candle time-dimension width setting. (default: `60`).
  int granularity;

  /// [Optional] Epoch value representing the earliest boundary of the returned ticks (For styles: 'ticks', this will default to 1 day ago. For styles: 'candle', it will default to 1 day ago if count or granularity is undefined).
  int start;

  /// [Optional] The tick-output style.
  String style;

  /// [Optional] 1 - to send updates whenever a new tick is received.
  int subscribe;

  /// Short symbol name (obtained from the `active_symbols` call).
  String ticksHistory;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
