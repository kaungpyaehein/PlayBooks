import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/bloc/shelf_details_bloc.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/pages/books_view.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';
import 'package:playbooks_flutter/resources/strings.dart';
import 'package:provider/provider.dart';

class ShelfDetailsView extends StatelessWidget {
  const ShelfDetailsView({super.key, required this.shelfVO});

  final ShelfVO shelfVO;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShelfDetailsBloc(shelfVO),
      child: Consumer<ShelfDetailsBloc>(
        builder: (context, bloc, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kBackgroundColor,
            ),
            body: CustomScrollView(
              slivers: [
                /// Edit Shelf Name View
                SliverToBoxAdapter(
                  child: EditShelfNameView(
                    shelfVO: shelfVO,
                  ),
                ),

                /// CategoryList to choose
                const CategoryList(),

                /// Sort bya and Change Grid or List View
                const SortingAndLayoutChangeViewShelf(),

                /// Books View
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSP16x,
                  ),
                  sliver: Builder(
                    builder: (context) {
                      switch (bloc.selectedView) {
                        case kViewList:
                          return BooksListView(
                            bookList: bloc.bookList,
                          );
                        case kViewLargeGrid:
                          return BooksLargeGridView(
                            bookList: bloc.bookList,
                          );
                        case kViewSmallGrid:
                          return BooksSmallGridView(
                            bookList: bloc.bookList,
                          );
                        default:
                          return BooksListView(
                            bookList: bloc.bookList,
                          );
                      }
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditShelfNameView extends StatefulWidget {
  const EditShelfNameView({super.key, required this.shelfVO});
  final ShelfVO shelfVO;
  @override
  State<EditShelfNameView> createState() => _EditShelfNameViewState();
}

class _EditShelfNameViewState extends State<EditShelfNameView> {
  final TextEditingController shelfNameController = TextEditingController();
  @override
  void initState() {
    shelfNameController.text = widget.shelfVO.shelfName ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSP16x),
      child: TextField(
        style: const TextStyle(
            color: kWhiteTextColor,
            fontWeight: FontWeight.w500,
            fontSize: kFontSize20x),
        controller: shelfNameController,
        onSubmitted: (newShelfName) {
          if (newShelfName != widget.shelfVO.shelfName) {
            final bloc = context.read<ShelfDetailsBloc>();
            bloc.editShelfName(
                widget.shelfVO.copyWith(shelfName: newShelfName));
          }
        },
        decoration: const InputDecoration(
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

//// Sorting and Toggle View for shelf
class SortingAndLayoutChangeViewShelf extends StatelessWidget {
  const SortingAndLayoutChangeViewShelf({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: kSP16x, vertical: kSP10x),
        child: Row(
          children: [
            Selector<ShelfDetailsBloc, String>(
                selector: (context, bloc) => bloc.selectedSortingStatus,
                builder: (context, selectedSortingStatus, child) {
                  return InkWell(
                    onTap: () {
                      showSortingBottomSheetShelf(
                          context, selectedSortingStatus);
                    },
                    child: const Icon(
                      Icons.sort,
                      color: kWhiteTextColor,
                    ),
                  );
                }),
            const SizedBox(
              width: kSP10x,
            ),
            Selector<ShelfDetailsBloc, String>(
              builder: (context, sortingStatus, child) {
                return Text(
                  "Sort By $sortingStatus",
                  style: const TextStyle(
                      color: kWhiteTextColor, fontWeight: FontWeight.w500),
                );
              },
              selector: (context, bloc) => bloc.selectedSortingStatus,
            ),
            const Spacer(),
            Selector<ShelfDetailsBloc, String>(
              selector: (context, bloc) => bloc.selectedView,
              builder: (context, selectedView, child) => InkWell(
                onTap: () {
                  showViewToggleBottomSheetShelf(context, selectedView);
                },
                child: buildIcon(selectedView),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showViewToggleBottomSheetShelf(
      BuildContext context, String selectedView) {
    return showModalBottomSheet(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(kSP10x)),
      context: context,
      builder: (_) => ViewSelectBottomSheetView(
        onChangeView: (view) {
          final bloc = context.read<ShelfDetailsBloc>();
          bloc.changeView(view);
          Navigator.pop(context);
        },
        selectedView: selectedView,
      ),
    );
  }

  Future<dynamic> showSortingBottomSheetShelf(
      BuildContext context, String selectedSortingStatus) {
    return showModalBottomSheet(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(kSP10x)),
      context: context,
      builder: (_) => SortingBottomSheetView(
        onTap: (sortingStatus) {
          final bloc = context.read<ShelfDetailsBloc>();
          bloc.sortBookBySortingStatus(sortingStatus);
          Navigator.pop(context);
        },
        selectedSortingStatus: selectedSortingStatus,
      ),
    );
  }
}
