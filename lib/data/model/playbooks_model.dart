import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/category_vo.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/network/data_agents/playbooks_data_agent.dart';
import 'package:playbooks_flutter/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:playbooks_flutter/persistence/dao/books_dao.dart';
import 'package:playbooks_flutter/persistence/dao/shelf_dao.dart';

class PlaybooksModel {
  static final PlaybooksModel _singleton = PlaybooksModel._internal();

  factory PlaybooksModel() {
    return _singleton;
  }

  PlaybooksModel._internal();

  final PlaybooksDataAgent _playbooksDataAgent = RetrofitDataAgentImpl();
  final BooksDao _booksDao = BooksDao();
  final ShelfDao _shelfDao = ShelfDao();

  Future<List<BookVO>> getBooksByCategoryAndDate(
    String date,
    String category,
  ) {
    return _playbooksDataAgent
        .getBooksByCategoryAndDate(category, date)
        .then((books) {
      return books;
    });
  }

  Future<List<CategoryVO>> getAllCategories() {
    return _playbooksDataAgent.getAllCategories();
  }

  /// Get Books Stream from Local database
  Stream<List<BookVO>> getBooksFromDatabaseStream() {
    return _booksDao.watchBookBox().map((_) => _booksDao.getAllBooks());
  }

  void addBookToDatabase(BookVO bookVO) {
    _booksDao.saveSingleBook(bookVO);
  }

  List<BookVO> getAllBooks() {
    return _booksDao.getAllBooks();
  }

  void createNewShelf(String name) {
    final ShelfVO shelfVO = ShelfVO(
      shelfName: name,
      bookList: [],
      shelfId: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _shelfDao.createNewShelf(shelfVO);
  }

  List<ShelfVO> getAllShelves() {
    return _shelfDao.getAllShelves();
  }

  Stream<List<ShelfVO>> getShelvesFromDatabase() {
    return _shelfDao.watchShelfBox().map((_) => _shelfDao.getAllShelves());
  }

  void editShelf(ShelfVO shelfVO) {
    _shelfDao.edit(shelfVO);
  }
}
