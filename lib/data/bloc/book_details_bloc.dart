import 'package:flutter/cupertino.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';

class BookDetailsBloc extends ChangeNotifier {
  final PlaybooksModel _model = PlaybooksModel();
  BookDetailsBloc(BookVO bookVO) {
    _model.addBookToDatabase(bookVO);
  }
}
