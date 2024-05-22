// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_books_by_category_and_date_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBooksByCategoryAndDateResponse _$GetBooksByCategoryAndDateResponseFromJson(
        Map<String, dynamic> json) =>
    GetBooksByCategoryAndDateResponse(
      status: json['status'] as String?,
      copyright: json['copyright'] as String?,
      numResults: (json['num_results'] as num?)?.toInt(),
      lastModified: json['last_modified'] as String?,
      results: json['results'] == null
          ? null
          : GetBooksByCategoryAndDateResult.fromJson(
              json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBooksByCategoryAndDateResponseToJson(
        GetBooksByCategoryAndDateResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'last_modified': instance.lastModified,
      'results': instance.results,
    };
