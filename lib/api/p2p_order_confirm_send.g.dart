// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'p2p_order_confirm_send.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

P2pOrderConfirmRequest _$P2pOrderConfirmRequestFromJson(
    Map<String, dynamic> json) {
  return P2pOrderConfirmRequest(
    id: json['id'] as String,
    p2pOrderConfirm: json['p2p_order_confirm'] as int,
    reqId: json['req_id'] as int,
    passthrough: json['passthrough'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$P2pOrderConfirmRequestToJson(
        P2pOrderConfirmRequest instance) =>
    <String, dynamic>{
      'req_id': instance.reqId,
      'passthrough': instance.passthrough,
      'id': instance.id,
      'p2p_order_confirm': instance.p2pOrderConfirm,
    };
