import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/category_vo.dart';
import 'package:playbooks_flutter/data/vos/google_book/google_book_vo.dart';

abstract class PlaybooksDataAgent {
  Future<List<BookVO>> getBooksByCategoryAndDate(
    String category,
    String date,
  );

  Future<List<CategoryVO>> getAllCategories();


  Future<List<GoogleBookVO>> searchBooks(String query);
}
