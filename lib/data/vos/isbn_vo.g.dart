// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isbn_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IsbnVOAdapter extends TypeAdapter<IsbnVO> {
  @override
  final int typeId = 2;

  @override
  IsbnVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IsbnVO(
      isbn10: fields[0] as String,
      isbn13: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IsbnVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isbn10)
      ..writeByte(1)
      ..write(obj.isbn13);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IsbnVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsbnVO _$IsbnVOFromJson(Map<String, dynamic> json) => IsbnVO(
      isbn10: json['isbn10'] as String,
      isbn13: json['isbn13'] as String,
    );

Map<String, dynamic> _$IsbnVOToJson(IsbnVO instance) => <String, dynamic>{
      'isbn10': instance.isbn10,
      'isbn13': instance.isbn13,
    };
