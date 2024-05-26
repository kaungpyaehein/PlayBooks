import 'package:json_annotation/json_annotation.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';

part 'google_book_vo.g.dart';

@JsonSerializable()
class GoogleBookVO {
  @JsonKey(name: 'kind')
  String? kind;

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'etag')
  String? eTag;

  @JsonKey(name: 'selfLink')
  String? selfLink;

  @JsonKey(name: 'volumeInfo')
  VolumeInfoVO? volumeInfo;

  @JsonKey(name: 'saleInfo')
  SaleInfoVO? saleInfo;

  @JsonKey(name: 'accessInfo')
  AccessInfoVO? accessInfo;

  @JsonKey(name: 'searchInfo')
  SearchInfoVO? searchInfo;

  GoogleBookVO({
    this.kind,
    this.id,
    this.eTag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  });

  factory GoogleBookVO.fromJson(Map<String, dynamic> json) =>
      _$GoogleBookVOFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleBookVOToJson(this);

  BookVO convertToBookVO() {
    return BookVO(
      primaryIsbn10: volumeInfo?.industryIdentifiers?[0].identifier ?? "",
      primaryIsbn13: volumeInfo?.industryIdentifiers?[1].identifier ?? "",
      title: volumeInfo?.title ?? "",
      author: volumeInfo?.authors?[0] ?? "",
      description: volumeInfo?.description ?? "",
      bookImage: volumeInfo?.imageLinks?.thumbnail ?? "",
      categoryName: "Google Books",
      publisher: volumeInfo?.publisher ?? "",
    );
  }
}

@JsonSerializable()
class VolumeInfoVO {
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'authors')
  List<String>? authors;

  @JsonKey(name: 'publisher')
  String? publisher;

  @JsonKey(name: 'publishedDate')
  String? publishedDate;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'industryIdentifiers')
  List<IdentifierVO>? industryIdentifiers;

  @JsonKey(name: 'readingModes')
  ReadingModeVO? readingModes;

  @JsonKey(name: 'pageCount')
  int? pageCount;

  @JsonKey(name: 'printType')
  String? printType;

  @JsonKey(name: 'categories')
  List<String>? categories;

  @JsonKey(name: 'maturityRating')
  String? maturityRating;

  @JsonKey(name: 'allowAnonLogging')
  bool? allowAnonLogging;

  @JsonKey(name: 'contentVersion')
  String? contentVersion;

  @JsonKey(name: 'panelizationSummary')
  PanelizationSummaryVO? panelizationSummary;

  @JsonKey(name: 'imageLinks')
  ImageLinksVO? imageLinks;

  @JsonKey(name: 'language')
  String? language;

  @JsonKey(name: 'previewLink')
  String? previewLink;

  @JsonKey(name: 'infoLink')
  String? infoLink;

  @JsonKey(name: 'canonicalVolumeLink')
  String? canonicalVolumeLink;

  VolumeInfoVO({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.industryIdentifiers,
    this.readingModes,
    this.pageCount,
    this.printType,
    this.categories,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.panelizationSummary,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
  });

  factory VolumeInfoVO.fromJson(Map<String, dynamic> json) =>
      _$VolumeInfoVOFromJson(json);
  Map<String, dynamic> toJson() => _$VolumeInfoVOToJson(this);
}

@JsonSerializable()
class IdentifierVO {
  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'identifier')
  String? identifier;

  IdentifierVO({this.type, this.identifier});

  factory IdentifierVO.fromJson(Map<String, dynamic> json) =>
      _$IdentifierVOFromJson(json);
  Map<String, dynamic> toJson() => _$IdentifierVOToJson(this);
}

@JsonSerializable()
class ReadingModeVO {
  @JsonKey(name: 'text')
  bool? text;

  @JsonKey(name: 'image')
  bool? image;

  ReadingModeVO({this.text, this.image});

  factory ReadingModeVO.fromJson(Map<String, dynamic> json) =>
      _$ReadingModeVOFromJson(json);
  Map<String, dynamic> toJson() => _$ReadingModeVOToJson(this);
}

@JsonSerializable()
class PanelizationSummaryVO {
  @JsonKey(name: 'containsEpubBubbles')
  bool? containsEpubBubbles;

  @JsonKey(name: 'containsImageBubbles')
  bool? containsImageBubbles;

  PanelizationSummaryVO({this.containsEpubBubbles, this.containsImageBubbles});

  factory PanelizationSummaryVO.fromJson(Map<String, dynamic> json) =>
      _$PanelizationSummaryVOFromJson(json);
  Map<String, dynamic> toJson() => _$PanelizationSummaryVOToJson(this);
}

@JsonSerializable()
class ImageLinksVO {
  @JsonKey(name: 'smallThumbnail')
  String? smallThumbnail;

  @JsonKey(name: 'thumbnail')
  String? thumbnail;

  ImageLinksVO({this.smallThumbnail, this.thumbnail});

  factory ImageLinksVO.fromJson(Map<String, dynamic> json) =>
      _$ImageLinksVOFromJson(json);
  Map<String, dynamic> toJson() => _$ImageLinksVOToJson(this);
}

@JsonSerializable()
class SaleInfoVO {
  @JsonKey(name: 'country')
  String? country;

  @JsonKey(name: 'saleability')
  String? saleability;

  @JsonKey(name: 'isEbook')
  bool? isEbook;

  SaleInfoVO({this.country, this.saleability, this.isEbook});

  factory SaleInfoVO.fromJson(Map<String, dynamic> json) =>
      _$SaleInfoVOFromJson(json);
  Map<String, dynamic> toJson() => _$SaleInfoVOToJson(this);
}

@JsonSerializable()
class AccessInfoVO {
  @JsonKey(name: 'country')
  String? country;

  @JsonKey(name: 'viewability')
  String? viewability;

  @JsonKey(name: 'embeddable')
  bool? embeddable;

  @JsonKey(name: 'publicDomain')
  bool? publicDomain;

  @JsonKey(name: 'textToSpeechPermission')
  String? textToSpeechPermission;

  @JsonKey(name: 'epub')
  AvailabilityVO? epub;

  @JsonKey(name: 'pdf')
  AvailabilityVO? pdf;

  @JsonKey(name: 'webReaderLink')
  String? webReaderLink;

  @JsonKey(name: 'accessViewStatus')
  String? accessViewStatus;

  @JsonKey(name: 'quoteSharingAllowed')
  bool? quoteSharingAllowed;

  AccessInfoVO({
    this.country,
    this.viewability,
    this.embeddable,
    this.publicDomain,
    this.textToSpeechPermission,
    this.epub,
    this.pdf,
    this.webReaderLink,
    this.accessViewStatus,
    this.quoteSharingAllowed,
  });

  factory AccessInfoVO.fromJson(Map<String, dynamic> json) =>
      _$AccessInfoVOFromJson(json);
  Map<String, dynamic> toJson() => _$AccessInfoVOToJson(this);
}

@JsonSerializable()
class AvailabilityVO {
  @JsonKey(name: 'isAvailable')
  bool? isAvailable;

  AvailabilityVO({this.isAvailable});

  factory AvailabilityVO.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityVOFromJson(json);
  Map<String, dynamic> toJson() => _$AvailabilityVOToJson(this);
}

@JsonSerializable()
class SearchInfoVO {
  @JsonKey(name: 'textSnippet')
  String? textSnippet;

  SearchInfoVO({this.textSnippet});

  factory SearchInfoVO.fromJson(Map<String, dynamic> json) =>
      _$SearchInfoVOFromJson(json);
  Map<String, dynamic> toJson() => _$SearchInfoVOToJson(this);
}
