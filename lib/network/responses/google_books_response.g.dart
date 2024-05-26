// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_books_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleBooksResponse _$GoogleBooksResponseFromJson(Map<String, dynamic> json) =>
    GoogleBooksResponse(
      kind: json['kind'] as String?,
      totalItems: (json['totalItems'] as num?)?.toInt(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => GoogleBookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GoogleBooksResponseToJson(
        GoogleBooksResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
