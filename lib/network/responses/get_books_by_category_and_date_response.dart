import 'package:json_annotation/json_annotation.dart';
import 'package:playbooks_flutter/network/responses/get_books_by_category_and_date_result.dart';

part 'get_books_by_category_and_date_response.g.dart';

@JsonSerializable()
class GetBooksByCategoryAndDateResponse {
  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "last_modified")
  String? lastModified;

  @JsonKey(name: "results")
  GetBooksByCategoryAndDateResult? results;

  GetBooksByCategoryAndDateResponse(
      {this.status,
        this.copyright,
        this.numResults,
        this.lastModified,
        this.results});
  factory GetBooksByCategoryAndDateResponse.fromJson(Map<String, dynamic> json) => _$GetBooksByCategoryAndDateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBooksByCategoryAndDateResponseToJson(this);

}
