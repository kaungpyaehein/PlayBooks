import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';

class CreateNewShelfBloc extends ChangeNotifier {
  final PlaybooksModel _model = PlaybooksModel();

  void createNewShelf(String name) {
    _model.createNewShelf(name);
  }
}
