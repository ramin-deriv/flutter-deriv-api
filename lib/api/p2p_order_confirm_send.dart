/// Autogenerated from flutter_deriv_api|lib/api/p2p_order_confirm_send.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'request.dart';

part 'p2p_order_confirm_send.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class P2pOrderConfirmRequest extends Request {
  ///
  P2pOrderConfirmRequest(
      {this.id,
      this.p2pOrderConfirm,
      int reqId,
      Map<String, dynamic> passthrough})
      : super(reqId: reqId, passthrough: passthrough);

  ///
  factory P2pOrderConfirmRequest.fromJson(Map<String, dynamic> json) =>
      _$P2pOrderConfirmRequestFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$P2pOrderConfirmRequestToJson(this);

  // Properties
  /// The unique identifier for this order.
  String id;

  /// Must be 1
  int p2pOrderConfirm;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
