import 'package:json_annotation/json_annotation.dart';
import 'package:playbooks_flutter/data/vos/category_vo.dart';

part 'get_all_categories_results.g.dart';
@JsonSerializable()
class GetAllCategoriesResults {
  @JsonKey(name: "bestsellers_date")
  String? bestsellersDate;

  @JsonKey(name: "published_date")
  String? publishedDate;

  @JsonKey(name: "published_date_description")
  String? publishedDateDescription;

  @JsonKey(name: "previous_published_date")
  String? previousPublishedDate;

  @JsonKey(name: "next_published_date")
  String? nextPublishedDate;

  @JsonKey(name: "lists")
  List<CategoryVO>? lists;



  GetAllCategoriesResults(
      {this.bestsellersDate,
      this.publishedDate,
      this.publishedDateDescription,
      this.previousPublishedDate,
      this.nextPublishedDate,
      this.lists,});

  factory GetAllCategoriesResults.fromJson(Map<String, dynamic> json) => _$GetAllCategoriesResultsFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCategoriesResultsToJson(this);
}
