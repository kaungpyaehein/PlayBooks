import 'package:hive_flutter/hive_flutter.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/persistence/hive_constants.dart';

class ShelfDao {
  static final ShelfDao _singleton = ShelfDao._internal();

  factory ShelfDao() {
    return _singleton;
  }

  ShelfDao._internal();

  List<ShelfVO> getAllShelves() {
    return getShelfBox().values.toList();
  }

  void edit(ShelfVO shelf) async {
    await getShelfBox().put(shelf.shelfId, shelf);
  }

  void createNewShelf(ShelfVO shelfVO) async {
    await getShelfBox().put(shelfVO.shelfId, shelfVO);
  }

  /// Get Movie Box from HIVE
  Box<ShelfVO> getShelfBox() {
    return Hive.box<ShelfVO>(kBoxNameShelfVO);
  }

  Stream watchShelfBox() {
    return getShelfBox().watch();
  }
}
