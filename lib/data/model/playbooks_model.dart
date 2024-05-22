import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/network/data_agents/playbooks_data_agent.dart';
import 'package:playbooks_flutter/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:playbooks_flutter/persistence/dao/books_dao.dart';

class PlaybooksModel {
  static final PlaybooksModel _singleton = PlaybooksModel._internal();

  factory PlaybooksModel() {
    return _singleton;
  }

  PlaybooksModel._internal();

  final PlaybooksDataAgent _playbooksDataAgent = RetrofitDataAgentImpl();
  final BooksDao _booksDao = BooksDao();

  Future<List<BookVO>> getBooksByCategoryAndDate(
    String date,
    String category,
  ) {
    return _playbooksDataAgent
        .getBooksByCategoryAndDate(category, date)
        .then((books) {
      /// save books to local
      _booksDao.saveBooks(books);
      return books;
    });
  }
}
