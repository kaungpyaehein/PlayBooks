import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';

class CarrouselBloc extends ChangeNotifier {
  final PlaybooksModel _model = PlaybooksModel();

  List<BookVO> bookList = [];

  StreamSubscription? _myCarrouselBooksSubscription;

  CarrouselBloc() {
    _myCarrouselBooksSubscription =
        _model.getBooksFromDatabaseStream().listen((booksFromDatabase) {
      bookList = booksFromDatabase;
      notifyListeners();
    });
    bookList = _model.getAllBooks();
    notifyListeners();
  }
  @override
  void dispose() {
    _myCarrouselBooksSubscription!.cancel();
    super.dispose();
  }
}
