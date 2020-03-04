/// Autogenerated from flutter_deriv_api|lib/api/app_get_receive.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'response.dart';

part 'app_get_receive.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class AppGetResponse extends Response {
  ///
  AppGetResponse(
      {this.appGet,
      int reqId,
      Map<String, dynamic> echoReq,
      String msgType,
      Map<String, dynamic> error})
      : super(reqId: reqId, echoReq: echoReq, msgType: msgType, error: error);

  ///
  factory AppGetResponse.fromJson(Map<String, dynamic> json) =>
      _$AppGetResponseFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$AppGetResponseToJson(this);

  // Properties
  /// The information of the requested application.
  Map<String, dynamic> appGet;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
