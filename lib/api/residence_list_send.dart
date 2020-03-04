/// Autogenerated from flutter_deriv_api|lib/api/residence_list_send.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'request.dart';

part 'residence_list_send.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class ResidenceListRequest extends Request {
  ///
  ResidenceListRequest(
      {this.residenceList, int reqId, Map<String, dynamic> passthrough})
      : super(reqId: reqId, passthrough: passthrough);

  ///
  factory ResidenceListRequest.fromJson(Map<String, dynamic> json) =>
      _$ResidenceListRequestFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$ResidenceListRequestToJson(this);

  // Properties

  /// Must be `1`
  int residenceList;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
