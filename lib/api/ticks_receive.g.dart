// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticks_receive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicksResponse _$TicksResponseFromJson(Map<String, dynamic> json) {
  return TicksResponse(
    subscription: json['subscription'] as Map<String, dynamic>,
    tick: json['tick'] as Map<String, dynamic>,
    reqId: json['req_id'] as int,
    echoReq: json['echo_req'] as Map<String, dynamic>,
    msgType: json['msg_type'] as String,
    error: json['error'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$TicksResponseToJson(TicksResponse instance) =>
    <String, dynamic>{
      'req_id': instance.reqId,
      'echo_req': instance.echoReq,
      'msg_type': instance.msgType,
      'error': instance.error,
      'subscription': instance.subscription,
      'tick': instance.tick,
    };
