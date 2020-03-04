/// Autogenerated from flutter_deriv_api|lib/api/mt5_deposit_send.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'request.dart';

part 'mt5_deposit_send.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class Mt5DepositRequest extends Request {
  ///
  Mt5DepositRequest(
      {this.amount,
      this.fromBinary,
      this.mt5Deposit,
      this.toMt5,
      int reqId,
      Map<String, dynamic> passthrough})
      : super(reqId: reqId, passthrough: passthrough);

  ///
  factory Mt5DepositRequest.fromJson(Map<String, dynamic> json) =>
      _$Mt5DepositRequestFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$Mt5DepositRequestToJson(this);

  // Properties
  /// Amount to deposit (in the currency of from_binary); min = $1 or an equivalent amount, max = $20000 or an equivalent amount
  num amount;

  /// Binary account loginid to transfer money from
  String fromBinary;

  /// Must be `1`
  int mt5Deposit;

  /// MT5 account login to deposit money to
  String toMt5;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
