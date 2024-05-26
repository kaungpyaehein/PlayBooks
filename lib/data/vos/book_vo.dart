import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:playbooks_flutter/data/vos/buy_link_vo.dart';
import 'package:playbooks_flutter/data/vos/isbn_vo.dart';
import 'package:playbooks_flutter/persistence/hive_constants.dart';

part 'book_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeIdBookVO, adapterName: kAdapterNameBookVO)
class BookVO {
  @HiveField(0)
  @JsonKey(name: "rank")
  int? rank; // Required

  @HiveField(1)
  @JsonKey(name: "rank_last_week")
  int? rankLastWeek; // Required

  @HiveField(2)
  @JsonKey(name: "weeks_on_list")
  int? weeksOnList; // Required

  @HiveField(3)
  @JsonKey(name: "asterisk")
  int? asterisk;

  @HiveField(4)
  @JsonKey(name: "dagger")
  int? dagger;

  @HiveField(5)
  @JsonKey(name: "primary_isbn10")
  String? primaryIsbn10; // Required

  @HiveField(6)
  @JsonKey(name: "primary_isbn13")
  String? primaryIsbn13; // Required

  @HiveField(7)
  @JsonKey(name: "publisher")
  String? publisher;

  @HiveField(8)
  @JsonKey(name: "description")
  String? description;

  @HiveField(9)
  @JsonKey(name: "price")
  String? price;

  @HiveField(10)
  @JsonKey(name: "title")
  String? title; // Required

  @HiveField(11)
  @JsonKey(name: "author")
  String? author; // Required

  @HiveField(12)
  @JsonKey(name: "contributor")
  String? contributor;

  @HiveField(13)
  @JsonKey(name: "contributor_note")
  String? contributorNote;

  @HiveField(14)
  @JsonKey(name: "book_image")
  String? bookImage;

  @HiveField(15)
  @JsonKey(name: "book_image_width")
  int? bookImageWidth;

  @HiveField(16)
  @JsonKey(name: "book_image_height")
  int? bookImageHeight;

  @HiveField(17)
  @JsonKey(name: "amazon_product_url")
  String? amazonProductUrl;

  @HiveField(18)
  @JsonKey(name: "age_group")
  String? ageGroup;

  @HiveField(19)
  @JsonKey(name: "book_review_link")
  String? bookReviewLink;

  @HiveField(20)
  @JsonKey(name: "first_chapter_link")
  String? firstChapterLink;

  @HiveField(21)
  @JsonKey(name: "sunday_review_link")
  String? sundayReviewLink;

  @HiveField(22)
  @JsonKey(name: "article_chapter_link")
  String? articleChapterLink;

  @HiveField(23)
  @JsonKey(name: "isbns")
  List<IsbnVO>? isbns;

  @HiveField(24)
  @JsonKey(name: "buy_links")
  List<BuyLinkVO>? buyLinks;

  @HiveField(25)
  @JsonKey(name: "book_uri")
  String? bookUri;

  @HiveField(26)
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? categoryName;

  BookVO({
    this.rank,
    this.rankLastWeek,
    this.weeksOnList,
    this.asterisk,
    this.dagger,
    required this.primaryIsbn10,
    required this.primaryIsbn13,
    this.publisher,
    this.description,
    this.price,
    this.title,
    this.author,
    this.contributor,
    this.contributorNote,
    this.bookImage,
    this.bookImageWidth,
    this.bookImageHeight,
    this.amazonProductUrl,
    this.ageGroup,
    this.bookReviewLink,
    this.firstChapterLink,
    this.sundayReviewLink,
    this.articleChapterLink,
    this.isbns,
    this.buyLinks,
    this.bookUri,
    this.categoryName,
  });

  factory BookVO.fromJson(Map<String, dynamic> json) => _$BookVOFromJson(json);

  Map<String, dynamic> toJson() => _$BookVOToJson(this);
}
