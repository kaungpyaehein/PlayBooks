import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:rxdart/rxdart.dart';

class SearchBookBloc extends ChangeNotifier {
  /// Movie Model
  final PlaybooksModel _model = PlaybooksModel();

  /// Two StreamControllers are set up
  // Widget to BloC
  StreamController<String> queryStreamController = StreamController();

  List<BookVO> resultBookList = [];

  /// SearchMovieBloc
  SearchBookBloc() {
    /// DEBOUNCE and Listen to the query stream controller
    queryStreamController.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen((query) {
      if (query.isNotEmpty) {
        debugPrint(query);
        _makeSearchMovieNetworkCalls(query);
      }
    });
  }

  /// Make network calls to search movies and sink it to the stream controller
  void _makeSearchMovieNetworkCalls(String query) {
    _model.searchBooks(query).then((searchResults) {
      resultBookList = searchResults;
      notifyListeners();
    }).catchError((error) {});
  }

  /// DISPOSE
  void onDispose() {
    queryStreamController.close();
  }
}
