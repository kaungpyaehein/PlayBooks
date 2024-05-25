import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/resources/strings.dart';

class YourBooksAndCarrouselBloc extends ChangeNotifier {
  final PlaybooksModel _model = PlaybooksModel();


  List<BookVO> bookList = [];

  List<String> categories = [];

  StreamSubscription? _myBooksSubscription;

  List<String> categoryList = [];

  late String selectedSortingStatus;
  late String selectedView;

  YourBooksAndCarrouselBloc() {
    selectedSortingStatus = kSortingRecent;
    selectedView = kViewSmallGrid;

    _myBooksSubscription =
        _model.getBooksFromDatabaseStream().listen((booksFromDatabase) {
      bookList = booksFromDatabase;
    });
    bookList = _model.geAllBooks();

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

  @override
  void dispose() {
    _myBooksSubscription?.cancel();
    super.dispose();
  }
}
