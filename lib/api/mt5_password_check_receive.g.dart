// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mt5_password_check_receive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mt5PasswordCheckResponse _$Mt5PasswordCheckResponseFromJson(
    Map<String, dynamic> json) {
  return Mt5PasswordCheckResponse(
    mt5PasswordCheck: json['mt5_password_check'] as int,
    reqId: json['req_id'] as int,
    echoReq: json['echo_req'] as Map<String, dynamic>,
    msgType: json['msg_type'] as String,
    error: json['error'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$Mt5PasswordCheckResponseToJson(
        Mt5PasswordCheckResponse instance) =>
    <String, dynamic>{
      'req_id': instance.reqId,
      'echo_req': instance.echoReq,
      'msg_type': instance.msgType,
      'error': instance.error,
      'mt5_password_check': instance.mt5PasswordCheck,
    };
