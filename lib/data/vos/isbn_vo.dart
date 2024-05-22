import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:playbooks_flutter/persistence/hive_constants.dart';

part 'isbn_vo.g.dart';

@HiveType(typeId: kHiveTypeIdIsbnVO, adapterName: kAdapterNameIsbnVO)
@JsonSerializable()
class IsbnVO {
  @HiveField(0)
  @JsonKey(name: "isbn10")
  String isbn10;

  @HiveField(1)
  @JsonKey(name: "isbn13")
  String isbn13;

  IsbnVO({
    required this.isbn10,
    required this.isbn13,
  });

  factory IsbnVO.fromJson(Map<String, dynamic> json) => _$IsbnVOFromJson(json);

  Map<String, dynamic> toJson() => _$IsbnVOToJson(this);
}
