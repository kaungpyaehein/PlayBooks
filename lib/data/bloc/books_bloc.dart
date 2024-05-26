import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/resources/strings.dart';

class BooksBloc extends ChangeNotifier {
  final PlaybooksModel _model = PlaybooksModel();

  List<BookVO> bookList = [];
  List<BookVO> allBooks = [];

  List<String> categories = [];

  StreamSubscription? _myBooksSubscription;

  List<String> categoryList = [];

  late String selectedSortingStatus;
  late String selectedView;
  late String selectedCategory;

  BooksBloc() {
    selectedSortingStatus = kSortingRecent;
    selectedView = kViewSmallGrid;

    _myBooksSubscription =
        _model.getBooksFromDatabaseStream().listen((booksFromDatabase) {
      bookList = booksFromDatabase;
      notifyListeners();
    });
    bookList = _model.getAllBooks();
    getCategories();
    selectedCategory = categories.first;
    allBooks = bookList;
    notifyListeners();
  }
  void sortBookBySortingStatus(String status) {
    selectedSortingStatus = status;
    if (status == kSortingRecent) {
      bookList.sort(
        (a, b) => a.primaryIsbn13!.compareTo(b.primaryIsbn13!),
      );
    } else if (status == kSortingTitle) {
      bookList.sort((a, b) => a.title!.compareTo(b.title!));
    } else if (status == kSortingAuthor) {
      bookList.sort((a, b) => a.author!.compareTo(b.author!));
    }
    notifyListeners();
  }

  void changeView(String newView) {
    selectedView = newView;
    notifyListeners();
  }

  void getCategories() {
    categories = bookList.map((book) => book.categoryName ?? "").toList();
    if (categories.isNotEmpty) {
      categories.insert(0, "All");
    }
  }

  void selectCategory(String category) {
    selectedCategory = category;
    if (category == "All") {
      bookList = List.from(allBooks);
    } else {
      bookList =
          allBooks.where((book) => book.categoryName == category).toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _myBooksSubscription?.cancel();
    super.dispose();
  }
}
