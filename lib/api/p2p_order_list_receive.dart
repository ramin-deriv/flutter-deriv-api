/// Autogenerated from flutter_deriv_api|lib/api/p2p_order_list_receive.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'response.dart';

part 'p2p_order_list_receive.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class P2pOrderListResponse extends Response {
  ///
  P2pOrderListResponse(
      {this.p2pOrderList,
      this.subscription,
      int reqId,
      Map<String, dynamic> echoReq,
      String msgType,
      Map<String, dynamic> error})
      : super(reqId: reqId, echoReq: echoReq, msgType: msgType, error: error);

  ///
  factory P2pOrderListResponse.fromJson(Map<String, dynamic> json) =>
      _$P2pOrderListResponseFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$P2pOrderListResponseToJson(this);

  // Properties

  /// List of P2P orders.
  Map<String, dynamic> p2pOrderList;

  /// For subscription requests only
  Map<String, dynamic> subscription;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
