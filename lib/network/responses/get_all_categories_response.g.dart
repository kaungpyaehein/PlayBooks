// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCategoriesResponse _$GetAllCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllCategoriesResponse(
      status: json['status'] as String?,
      copyright: json['copyright'] as String?,
      numResults: (json['num_results'] as num?)?.toInt(),
      results: json['results'] == null
          ? null
          : GetAllCategoriesResults.fromJson(
              json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAllCategoriesResponseToJson(
        GetAllCategoriesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'results': instance.results,
    };
