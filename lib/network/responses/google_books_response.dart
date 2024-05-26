import 'package:json_annotation/json_annotation.dart';
import 'package:playbooks_flutter/data/vos/google_book/google_book_vo.dart';

part 'google_books_response.g.dart';

@JsonSerializable()
class GoogleBooksResponse {
  @JsonKey(name: "kind")
  String? kind;
  @JsonKey(name: "totalItems")
  int? totalItems;
  @JsonKey(name: "items")
  List<GoogleBookVO>? items;

  factory GoogleBooksResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleBooksResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleBooksResponseToJson(this);

  GoogleBooksResponse({this.kind, this.totalItems, this.items});
}
