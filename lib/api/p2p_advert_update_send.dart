/// Autogenerated from flutter_deriv_api|lib/api/p2p_advert_update_send.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'request.dart';

part 'p2p_advert_update_send.g.dart';

/// JSON conversion for 'p2p_advert_update_send'
@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class P2pAdvertUpdateRequest extends Request {
  /// Initialize P2pAdvertUpdateRequest
  P2pAdvertUpdateRequest(
      {this.delete,
      this.id,
      this.isActive,
      this.p2pAdvertUpdate = 1,
      Map<String, dynamic> passthrough,
      int reqId})
      : super(passthrough: passthrough, reqId: reqId);

  /// Creates instance from JSON
  factory P2pAdvertUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$P2pAdvertUpdateRequestFromJson(json);

  // Properties
  /// [Optional] If set to 1, permanently deletes the advert.
  int delete;

  /// The unique identifier for this advert.
  String id;

  /// [Optional] Activate or deactivate the advert.
  int isActive;

  /// Must be 1
  int p2pAdvertUpdate;

  /// Converts to JSON
  @override
  Map<String, dynamic> toJson() => _$P2pAdvertUpdateRequestToJson(this);
}
