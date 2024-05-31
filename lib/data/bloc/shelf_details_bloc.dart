import 'package:flutter/cupertino.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/resources/strings.dart';

class ShelfDetailsBloc extends ChangeNotifier {
  final PlaybooksModel _model = PlaybooksModel();
  List<BookVO> bookList = [];

  List<BookVO> allBooks = [];

  List<String> categories = [];

  late String selectedSortingStatus;
  late String selectedView;
  late String selectedCategory;

  ShelfDetailsBloc(ShelfVO shelfVO) {
    selectedSortingStatus = kSortingRecent;
    selectedView = kViewSmallGrid;
    bookList = shelfVO.bookList ?? [];

    allBooks = bookList;
    getCategories();
    if (categories.isNotEmpty) {
      selectedCategory = categories.first;
    }
    notifyListeners();
  }

  void changeView(String newView) {
    selectedView = newView;
    notifyListeners();
  }

  void sortBookBySortingStatus(String status) {
    selectedSortingStatus = status;
    notifyListeners();

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

  void editShelfName(ShelfVO shelf) {
    _model.editShelf(shelf);
  }
}
