/// Autogenerated from flutter_deriv_api|lib/api/login_history_receive.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'response.dart';

part 'login_history_receive.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class LoginHistoryResponse extends Response {
  ///
  LoginHistoryResponse(
      {this.loginHistory,
      int reqId,
      Map<String, dynamic> echoReq,
      String msgType,
      Map<String, dynamic> error})
      : super(reqId: reqId, echoReq: echoReq, msgType: msgType, error: error);

  ///
  factory LoginHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginHistoryResponseFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$LoginHistoryResponseToJson(this);

  // Properties

  /// Array of records of client login/logout activities
  List<Map<String, dynamic>> loginHistory;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
