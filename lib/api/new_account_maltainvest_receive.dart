/// Autogenerated from flutter_deriv_api|lib/api/new_account_maltainvest_receive.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'response.dart';

part 'new_account_maltainvest_receive.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class NewAccountMaltainvestResponse extends Response {
  ///
  NewAccountMaltainvestResponse(
      {this.newAccountMaltainvest,
      int reqId,
      Map<String, dynamic> echoReq,
      String msgType,
      Map<String, dynamic> error})
      : super(reqId: reqId, echoReq: echoReq, msgType: msgType, error: error);

  ///
  factory NewAccountMaltainvestResponse.fromJson(Map<String, dynamic> json) =>
      _$NewAccountMaltainvestResponseFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$NewAccountMaltainvestResponseToJson(this);

  // Properties

  /// New `maltainvest` account details
  Map<String, dynamic> newAccountMaltainvest;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
