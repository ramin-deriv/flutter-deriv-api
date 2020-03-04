/// Autogenerated from flutter_deriv_api|lib/api/payout_currencies_send.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'request.dart';

part 'payout_currencies_send.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class PayoutCurrenciesRequest extends Request {
  ///
  PayoutCurrenciesRequest(
      {this.payoutCurrencies, int reqId, Map<String, dynamic> passthrough})
      : super(reqId: reqId, passthrough: passthrough);

  ///
  factory PayoutCurrenciesRequest.fromJson(Map<String, dynamic> json) =>
      _$PayoutCurrenciesRequestFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$PayoutCurrenciesRequestToJson(this);

  // Properties

  /// Must be `1`
  int payoutCurrencies;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
