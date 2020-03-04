/// Autogenerated from flutter_deriv_api|lib/api/app_markup_details_send.json
import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'request.dart';

part 'app_markup_details_send.g.dart';

///
@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class AppMarkupDetailsRequest extends Request {
  ///
  AppMarkupDetailsRequest(
      {this.appId,
      this.appMarkupDetails,
      this.clientLoginid,
      this.dateFrom,
      this.dateTo,
      this.description,
      this.limit,
      this.offset,
      this.sort,
      this.sortFields,
      int reqId,
      Map<String, dynamic> passthrough})
      : super(reqId: reqId, passthrough: passthrough);

  ///
  factory AppMarkupDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$AppMarkupDetailsRequestFromJson(json);

  ///
  @override
  Map<String, dynamic> toJson() => _$AppMarkupDetailsRequestToJson(this);

  // Properties
  /// [Optional] Specific application `app_id` to report on.
  int appId;

  /// Must be `1`
  int appMarkupDetails;

  /// [Optional] Specific client loginid to report on, like CR12345
  String clientLoginid;

  /// Start date (epoch or YYYY-MM-DD HH:MM:SS). Results are inclusive of this time.
  String dateFrom;

  /// End date (epoch or YYYY-MM-DD HH::MM::SS). Results are inclusive of this time.
  String dateTo;

  /// [Optional] If set to 1, will return `app_markup` transaction details.
  int description;

  /// [Optional] Apply upper limit to count of transactions received.
  num limit;

  /// [Optional] Number of transactions to skip.
  num offset;

  /// [Optional] Sort direction on `transaction_time`. Other fields sort order is ASC.
  String sort;

  /// [Optional] One or more of the specified fields to sort on. Default sort field is by `transaction_time`.
  List<String> sortFields;

  // @override
  // String toString() => name;
  static bool _fromInteger(int v) => (v != 0);
  static int _fromBoolean(bool v) => v ? 1 : 0;
}
