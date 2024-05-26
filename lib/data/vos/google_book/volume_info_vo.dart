import 'dart:core';

class VolumeInfoVO {
  String? title;
  List<String>? authors;
  String? publisher;
  String? publishedDate;
  String? description;
  List<IdentifierVO>? industryIdentifiers;
  ReadingModeVO? readingModes;
  int? pageCount;
  String? printType;
  List<String>? categories;
  String? maturityRating;
  bool? allowAnonLogging;
  String? contentVersion;
  PanelizationSummaryVO? panelizationSummary;
  ImageLinksVO? imageLinks;
  String? language;
  String? previewLink;
  String? infoLink;
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
}

class IdentifierVO {
  String? type;
  String? identifier;

  IdentifierVO({this.type, this.identifier});
}

class ReadingModeVO {
  bool? text;
  bool? image;

  ReadingModeVO({this.text, this.image});
}

class PanelizationSummaryVO {
  bool? containsEpubBubbles;
  bool? containsImageBubbles;

  PanelizationSummaryVO({this.containsEpubBubbles, this.containsImageBubbles});
}

class ImageLinksVO {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinksVO({this.smallThumbnail, this.thumbnail});
}
