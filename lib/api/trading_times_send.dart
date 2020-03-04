/// Autogenerated from flutter_deriv_api|lib/api/trading_times_send.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'request.dart';

part 'trading_times_send.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class TradingTimesRequest extends Request {
  ///
  TradingTimesRequest(
      {this.tradingTimes, int reqId, Map<String, dynamic> passthrough})
      : super(reqId: reqId, passthrough: passthrough);

  ///
  factory TradingTimesRequest.fromJson(Map<String, dynamic> json) =>
      _$TradingTimesRequestFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$TradingTimesRequestToJson(this);

  // Properties

  /// Date to receive market opening times for. (`yyyy-mm-dd` format. `today` can also be specified).
  String tradingTimes;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
