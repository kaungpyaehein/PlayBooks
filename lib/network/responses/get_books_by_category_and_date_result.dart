import 'package:json_annotation/json_annotation.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';

part 'get_books_by_category_and_date_result.g.dart';

@JsonSerializable()
class GetBooksByCategoryAndDateResult {
  @JsonKey(name: "list_name")
  String? listName;

  @JsonKey(name: "list_name_encoded")
  String? listNameEncoded;

  @JsonKey(name: "bestsellers_date")
  String? bestsellersDate;

  @JsonKey(name: "published_date")
  String? publishedDate;

  @JsonKey(name: "published_date_description")
  String? publishedDateDescription;

  @JsonKey(name: "next_published_date")
  String? nextPublishedDate;

  @JsonKey(name: "previous_published_date")
  String? previousPublishedDate;

  @JsonKey(name: "display_name")
  String? displayName;

  @JsonKey(name: "normal_list_ends_at")
  int? normalListEndsAt;

  @JsonKey(name: "updated")
  String? updated;

  @JsonKey(name: "books")
  List<BookVO>? books;

  GetBooksByCategoryAndDateResult(
      {this.listName,
      this.listNameEncoded,
      this.bestsellersDate,
      this.publishedDate,
      this.publishedDateDescription,
      this.nextPublishedDate,
      this.previousPublishedDate,
      this.displayName,
      this.normalListEndsAt,
      this.updated,
      this.books});

  factory GetBooksByCategoryAndDateResult.fromJson(Map<String, dynamic> json) =>
      _$GetBooksByCategoryAndDateResultFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetBooksByCategoryAndDateResultToJson(this);
}
