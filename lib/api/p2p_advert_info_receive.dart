/// Autogenerated from flutter_deriv_api|lib/api/p2p_advert_info_receive.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'response.dart';

part 'p2p_advert_info_receive.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class P2pAdvertInfoResponse extends Response {
  ///
  P2pAdvertInfoResponse(
      {this.p2pAdvertInfo,
      int reqId,
      Map<String, dynamic> echoReq,
      String msgType,
      Map<String, dynamic> error})
      : super(reqId: reqId, echoReq: echoReq, msgType: msgType, error: error);

  ///
  factory P2pAdvertInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$P2pAdvertInfoResponseFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$P2pAdvertInfoResponseToJson(this);

  // Properties

  /// P2P advert information.
  Map<String, dynamic> p2pAdvertInfo;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
