// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_books_by_category_and_date_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBooksByCategoryAndDateResult _$GetBooksByCategoryAndDateResultFromJson(
        Map<String, dynamic> json) =>
    GetBooksByCategoryAndDateResult(
      listName: json['list_name'] as String?,
      listNameEncoded: json['list_name_encoded'] as String?,
      bestsellersDate: json['bestsellers_date'] as String?,
      publishedDate: json['published_date'] as String?,
      publishedDateDescription: json['published_date_description'] as String?,
      nextPublishedDate: json['next_published_date'] as String?,
      previousPublishedDate: json['previous_published_date'] as String?,
      displayName: json['display_name'] as String?,
      normalListEndsAt: (json['normal_list_ends_at'] as num?)?.toInt(),
      updated: json['updated'] as String?,
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBooksByCategoryAndDateResultToJson(
        GetBooksByCategoryAndDateResult instance) =>
    <String, dynamic>{
      'list_name': instance.listName,
      'list_name_encoded': instance.listNameEncoded,
      'bestsellers_date': instance.bestsellersDate,
      'published_date': instance.publishedDate,
      'published_date_description': instance.publishedDateDescription,
      'next_published_date': instance.nextPublishedDate,
      'previous_published_date': instance.previousPublishedDate,
      'display_name': instance.displayName,
      'normal_list_ends_at': instance.normalListEndsAt,
      'updated': instance.updated,
      'books': instance.books,
    };
