class SaleInfoVO {
  String? country;
  String? saleability;
  bool? isEbook;

  SaleInfoVO({this.country, this.saleability, this.isEbook});
}

class AccessInfoVO {
  String? country;
  String? viewability;
  bool? embeddable;
  bool? publicDomain;
  String? textToSpeechPermission;
  AvailabilityVO? epub;
  AvailabilityVO? pdf;
  String? webReaderLink;
  String? accessViewStatus;
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
}

class AvailabilityVO {
  bool? isAvailable;

  AvailabilityVO({this.isAvailable});
}

class SearchInfoVO {
  String? textSnippet;

  SearchInfoVO({this.textSnippet});
}
