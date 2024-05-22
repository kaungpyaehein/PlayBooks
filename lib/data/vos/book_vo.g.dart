// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookVOAdapter extends TypeAdapter<BookVO> {
  @override
  final int typeId = 0;

  @override
  BookVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookVO(
      rank: fields[0] as int?,
      rankLastWeek: fields[1] as int?,
      weeksOnList: fields[2] as int?,
      asterisk: fields[3] as int?,
      dagger: fields[4] as int?,
      primaryIsbn10: fields[5] as String?,
      primaryIsbn13: fields[6] as String?,
      publisher: fields[7] as String?,
      description: fields[8] as String?,
      price: fields[9] as String?,
      title: fields[10] as String?,
      author: fields[11] as String?,
      contributor: fields[12] as String?,
      contributorNote: fields[13] as String?,
      bookImage: fields[14] as String?,
      bookImageWidth: fields[15] as int?,
      bookImageHeight: fields[16] as int?,
      amazonProductUrl: fields[17] as String?,
      ageGroup: fields[18] as String?,
      bookReviewLink: fields[19] as String?,
      firstChapterLink: fields[20] as String?,
      sundayReviewLink: fields[21] as String?,
      articleChapterLink: fields[22] as String?,
      isbns: (fields[23] as List?)?.cast<IsbnVO>(),
      buyLinks: (fields[24] as List?)?.cast<BuyLinkVO>(),
      bookUri: fields[25] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BookVO obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.rank)
      ..writeByte(1)
      ..write(obj.rankLastWeek)
      ..writeByte(2)
      ..write(obj.weeksOnList)
      ..writeByte(3)
      ..write(obj.asterisk)
      ..writeByte(4)
      ..write(obj.dagger)
      ..writeByte(5)
      ..write(obj.primaryIsbn10)
      ..writeByte(6)
      ..write(obj.primaryIsbn13)
      ..writeByte(7)
      ..write(obj.publisher)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(10)
      ..write(obj.title)
      ..writeByte(11)
      ..write(obj.author)
      ..writeByte(12)
      ..write(obj.contributor)
      ..writeByte(13)
      ..write(obj.contributorNote)
      ..writeByte(14)
      ..write(obj.bookImage)
      ..writeByte(15)
      ..write(obj.bookImageWidth)
      ..writeByte(16)
      ..write(obj.bookImageHeight)
      ..writeByte(17)
      ..write(obj.amazonProductUrl)
      ..writeByte(18)
      ..write(obj.ageGroup)
      ..writeByte(19)
      ..write(obj.bookReviewLink)
      ..writeByte(20)
      ..write(obj.firstChapterLink)
      ..writeByte(21)
      ..write(obj.sundayReviewLink)
      ..writeByte(22)
      ..write(obj.articleChapterLink)
      ..writeByte(23)
      ..write(obj.isbns)
      ..writeByte(24)
      ..write(obj.buyLinks)
      ..writeByte(25)
      ..write(obj.bookUri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookVO _$BookVOFromJson(Map<String, dynamic> json) => BookVO(
      rank: (json['rank'] as num?)?.toInt(),
      rankLastWeek: (json['rank_last_week'] as num?)?.toInt(),
      weeksOnList: (json['weeks_on_list'] as num?)?.toInt(),
      asterisk: (json['asterisk'] as num?)?.toInt(),
      dagger: (json['dagger'] as num?)?.toInt(),
      primaryIsbn10: json['primary_isbn10'] as String?,
      primaryIsbn13: json['primary_isbn13'] as String?,
      publisher: json['publisher'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      title: json['title'] as String?,
      author: json['author'] as String?,
      contributor: json['contributor'] as String?,
      contributorNote: json['contributor_note'] as String?,
      bookImage: json['book_image'] as String?,
      bookImageWidth: (json['book_image_width'] as num?)?.toInt(),
      bookImageHeight: (json['book_image_height'] as num?)?.toInt(),
      amazonProductUrl: json['amazon_product_url'] as String?,
      ageGroup: json['age_group'] as String?,
      bookReviewLink: json['book_review_link'] as String?,
      firstChapterLink: json['first_chapter_link'] as String?,
      sundayReviewLink: json['sunday_review_link'] as String?,
      articleChapterLink: json['article_chapter_link'] as String?,
      isbns: (json['isbns'] as List<dynamic>?)
          ?.map((e) => IsbnVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      buyLinks: (json['buy_links'] as List<dynamic>?)
          ?.map((e) => BuyLinkVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookUri: json['book_uri'] as String?,
    );

Map<String, dynamic> _$BookVOToJson(BookVO instance) => <String, dynamic>{
      'rank': instance.rank,
      'rank_last_week': instance.rankLastWeek,
      'weeks_on_list': instance.weeksOnList,
      'asterisk': instance.asterisk,
      'dagger': instance.dagger,
      'primary_isbn10': instance.primaryIsbn10,
      'primary_isbn13': instance.primaryIsbn13,
      'publisher': instance.publisher,
      'description': instance.description,
      'price': instance.price,
      'title': instance.title,
      'author': instance.author,
      'contributor': instance.contributor,
      'contributor_note': instance.contributorNote,
      'book_image': instance.bookImage,
      'book_image_width': instance.bookImageWidth,
      'book_image_height': instance.bookImageHeight,
      'amazon_product_url': instance.amazonProductUrl,
      'age_group': instance.ageGroup,
      'book_review_link': instance.bookReviewLink,
      'first_chapter_link': instance.firstChapterLink,
      'sunday_review_link': instance.sundayReviewLink,
      'article_chapter_link': instance.articleChapterLink,
      'isbns': instance.isbns,
      'buy_links': instance.buyLinks,
      'book_uri': instance.bookUri,
    };
