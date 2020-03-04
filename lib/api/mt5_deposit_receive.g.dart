// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mt5_deposit_receive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mt5DepositResponse _$Mt5DepositResponseFromJson(Map<String, dynamic> json) {
  return Mt5DepositResponse(
    binaryTransactionId: json['binary_transaction_id'] as int,
    mt5Deposit: json['mt5_deposit'] as int,
    reqId: json['req_id'] as int,
    echoReq: json['echo_req'] as Map<String, dynamic>,
    msgType: json['msg_type'] as String,
    error: json['error'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$Mt5DepositResponseToJson(Mt5DepositResponse instance) =>
    <String, dynamic>{
      'req_id': instance.reqId,
      'echo_req': instance.echoReq,
      'msg_type': instance.msgType,
      'error': instance.error,
      'binary_transaction_id': instance.binaryTransactionId,
      'mt5_deposit': instance.mt5Deposit,
    };
