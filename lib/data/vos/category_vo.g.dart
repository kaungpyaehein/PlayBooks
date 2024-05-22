// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryVO _$CategoryVOFromJson(Map<String, dynamic> json) => CategoryVO(
      listId: (json['list_id'] as num?)?.toInt(),
      listName: json['list_name'] as String?,
      listNameEncoded: json['list_name_encoded'] as String?,
      displayName: json['display_name'] as String?,
      updated: json['updated'] as String?,
      listImage: json['list_image'] as String?,
      listImageWidth: (json['list_image_width'] as num?)?.toInt(),
      listImageHeight: (json['list_image_height'] as num?)?.toInt(),
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryVOToJson(CategoryVO instance) =>
    <String, dynamic>{
      'list_id': instance.listId,
      'list_name': instance.listName,
      'list_name_encoded': instance.listNameEncoded,
      'display_name': instance.displayName,
      'updated': instance.updated,
      'list_image': instance.listImage,
      'list_image_width': instance.listImageWidth,
      'list_image_height': instance.listImageHeight,
      'books': instance.books,
    };
