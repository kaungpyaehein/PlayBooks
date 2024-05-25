import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/category_vo.dart';
import 'package:playbooks_flutter/resources/strings.dart';

class HomePageBloc extends ChangeNotifier {
  final PlaybooksModel _playbooksModel = PlaybooksModel();

  /// Now Playing or Coming Soon
  late String selectedText;

  List<CategoryVO> categoryList = [];

  HomePageBloc() {
    selectedText = kEbooksLabel;

    /// Get categories and add to categoryList
    _playbooksModel.getAllCategories().then((categories) {
      categoryList = categories;
      notifyListeners();
    });
  }

  void onTapEbooksAndAudioBooks(String text) {
    selectedText = text;

    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
