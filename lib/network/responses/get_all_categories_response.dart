import 'package:json_annotation/json_annotation.dart';
import 'package:playbooks_flutter/network/responses/get_all_categories_results.dart';

part 'get_all_categories_response.g.dart';

@JsonSerializable()
class GetAllCategoriesResponse {
  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "results")
  GetAllCategoriesResults? results;

  GetAllCategoriesResponse({
    this.status,
    this.copyright,
    this.numResults,
    this.results,
  });

  factory GetAllCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCategoriesResponseToJson(this);
}
