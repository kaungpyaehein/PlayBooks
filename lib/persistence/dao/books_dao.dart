import 'package:hive_flutter/hive_flutter.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/persistence/hive_constants.dart';

class BooksDao {
  static final BooksDao _singleton = BooksDao._internal();

  factory BooksDao() {
    return _singleton;
  }

  BooksDao._internal();
  //
  // void saveBooks(List<BookVO> books) async {
  //   /// {} represents Map
  //   Map<int, BookVO> bookMap = {
  //     for (var book in books) int.parse(book.primaryIsbn10 ?? "0"): book
  //   };
  //   await getBookBox().putAll(bookMap);
  // }

  void saveSingleBook(BookVO book) async {
    await getBookBox().put(book.primaryIsbn10 ?? "", book);
  }

  BookVO? getBookByIsbn10(String primaryIsbn10) {
    return getBookBox().get(int.parse(primaryIsbn10));
  }

  /// Get Movie Box from HIVE
  Box<BookVO> getBookBox() {
    return Hive.box<BookVO>(kBoxNameBookVO);
  }

  List<BookVO> getAllBooks() {
    return getBookBox().values.toList();
  }

  Stream watchBookBox() {
    return getBookBox().watch();
  }
}
