/// Autogenerated from flutter_deriv_api|lib/api/revoke_oauth_app_send.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'request.dart';

part 'revoke_oauth_app_send.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class RevokeOauthAppRequest extends Request {
  ///
  RevokeOauthAppRequest(
      {this.revokeOauthApp, int reqId, Map<String, dynamic> passthrough})
      : super(reqId: reqId, passthrough: passthrough);

  ///
  factory RevokeOauthAppRequest.fromJson(Map<String, dynamic> json) =>
      _$RevokeOauthAppRequestFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$RevokeOauthAppRequestToJson(this);

  // Properties

  /// The application ID to revoke.
  int revokeOauthApp;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
