/// Autogenerated from flutter_deriv_api|lib/api/profit_table_receive.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'response.dart';

part 'profit_table_receive.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class ProfitTableResponse extends Response {
  ///
  ProfitTableResponse(
      {this.profitTable,
      int reqId,
      Map<String, dynamic> echoReq,
      String msgType,
      Map<String, dynamic> error})
      : super(reqId: reqId, echoReq: echoReq, msgType: msgType, error: error);

  ///
  factory ProfitTableResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfitTableResponseFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$ProfitTableResponseToJson(this);

  // Properties

  /// Account Profit Table.
  Map<String, dynamic> profitTable;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
