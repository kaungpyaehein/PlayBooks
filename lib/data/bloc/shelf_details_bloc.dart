import 'package:flutter/cupertino.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/resources/strings.dart';

class ShelfDetailsBloc extends ChangeNotifier {
  List<BookVO> bookList = [];

  late String selectedSortingStatus;
  late String selectedView;

  ShelfDetailsBloc(ShelfVO shelfVO) {
    selectedSortingStatus = kSortingRecent;
    selectedView = kViewSmallGrid;
    bookList = shelfVO.bookList ?? [];
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
}
