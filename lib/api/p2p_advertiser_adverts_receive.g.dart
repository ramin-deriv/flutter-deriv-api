// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'p2p_advertiser_adverts_receive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

P2pAdvertiserAdvertsResponse _$P2pAdvertiserAdvertsResponseFromJson(
    Map<String, dynamic> json) {
  return P2pAdvertiserAdvertsResponse(
    p2pAdvertiserAdverts:
        json['p2p_advertiser_adverts'] as Map<String, dynamic>,
    reqId: json['req_id'] as int,
    echoReq: json['echo_req'] as Map<String, dynamic>,
    msgType: json['msg_type'] as String,
    error: json['error'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$P2pAdvertiserAdvertsResponseToJson(
        P2pAdvertiserAdvertsResponse instance) =>
    <String, dynamic>{
      'req_id': instance.reqId,
      'echo_req': instance.echoReq,
      'msg_type': instance.msgType,
      'error': instance.error,
      'p2p_advertiser_adverts': instance.p2pAdvertiserAdverts,
    };
