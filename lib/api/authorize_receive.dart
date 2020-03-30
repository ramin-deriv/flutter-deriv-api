/// Autogenerated from flutter_deriv_api|lib/api/authorize_receive.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'response.dart';

part 'authorize_receive.g.dart';

/// JSON conversion for 'authorize_receive'
@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class AuthorizeResponse extends Response {
  /// Initialize AuthorizeResponse
  AuthorizeResponse(
      {this.authorize,
      Map<String, dynamic> echoReq,
      Map<String, dynamic> error,
      String msgType,
      int reqId})
      : super(echoReq: echoReq, error: error, msgType: msgType, reqId: reqId);

  /// Creates instance from JSON
  factory AuthorizeResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthorizeResponseFromJson(json);

  // Properties
  /// Account information for the holder of the token.
  Map<String, dynamic> authorize;

  /// Converts to JSON
  @override
  Map<String, dynamic> toJson() => _$AuthorizeResponseToJson(this);
}
