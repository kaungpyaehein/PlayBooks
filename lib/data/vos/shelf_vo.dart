import 'package:hive_flutter/hive_flutter.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/persistence/hive_constants.dart';

part 'shelf_vo.g.dart';

@HiveType(typeId: kHiveTypeShelfVO, adapterName: kAdapterNameShelfVO)
class ShelfVO {
  @HiveField(0)
  String? shelfId;
  @HiveField(1)
  String? shelfName;
  @HiveField(2)
  List<BookVO>? bookList;

  ShelfVO({
    this.shelfId,
    this.shelfName,
    this.bookList = const [],
  });

  ShelfVO copyWith({
    String? shelfId,
    String? shelfName,
    List<BookVO>? bookList,
  }) {
    return ShelfVO(
      shelfId: shelfId ?? this.shelfId,
      shelfName: shelfName ?? this.shelfName,
      bookList: bookList ?? this.bookList,
    );
  }
}
