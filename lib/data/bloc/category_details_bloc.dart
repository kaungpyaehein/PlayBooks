import 'package:flutter/foundation.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/network/api_constants.dart';

class CategoryDetailsBloc extends ChangeNotifier {
  List<BookVO> bookList = [];

  final PlaybooksModel _playbooksModelModel = PlaybooksModel();
  CategoryDetailsBloc(String categoryName) {
    /// Get Books by Category name and display
    _playbooksModelModel
        .getBooksByCategoryAndDate(kCurrentDate, categoryName)
        .then((books) {

      bookList = books;
      notifyListeners();
    });
  }
}
