import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';

import 'dart:async';

class ShelfBloc extends ChangeNotifier {
  final PlaybooksModel _model = PlaybooksModel();

  List<ShelfVO> shelfList = [];

  StreamSubscription? _shelfStream;
  ShelfBloc() {
    _shelfStream = _model.getShelvesFromDatabase().listen((shelves) {
      shelfList = shelves;
      notifyListeners();
    });
    shelfList = _model.getAllShelves();
    notifyListeners();
  }

  void addNewBookToShelf(BookVO bookVO, ShelfVO shelfVO) {
    final List<BookVO> updatedBookList =
        List<BookVO>.from(shelfVO.bookList ?? []);
    if (!updatedBookList.contains(bookVO)) {
      updatedBookList.add(bookVO);
      final ShelfVO newShelf = shelfVO.copyWith(bookList: updatedBookList);

      _model.editShelf(newShelf);
      notifyListeners();
    }
  }
  void editShelfName(ShelfVO shelfVO){
    _model.editShelf(shelfVO);
    notifyListeners();
  }

  @override
  void dispose() {
    _shelfStream!.cancel();
    super.dispose();
  }
}
