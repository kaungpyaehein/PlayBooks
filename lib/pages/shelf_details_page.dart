import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/bloc/shelf_details_bloc.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/pages/library_page.dart';
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
      child: Scaffold(
        appBar: AppBar(),
        body: CustomScrollView(
          slivers: [
            /// CategoryList to choose
            const CategoryList(),

            /// Sort bya and Change Grid or List View
            const SortingAndLayoutChangeViewShelf(),

            /// Books View
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSP16x,
              ),
              sliver: Consumer<ShelfDetailsBloc>(
                builder: (context, bloc, child) {
                  if (bloc.selectedView == kViewList) {
                    return BooksListView(
                      bookList: bloc.bookList,
                    );
                  } else if (bloc.selectedView == kViewLargeGrid) {
                    return BooksLargeGridView(
                      bookList: bloc.bookList,
                    );
                  } else if (bloc.selectedView == kViewSmallGrid) {
                    return BooksSmallGridView(
                      bookList: bloc.bookList,
                    );
                  }
                  return BooksListView(
                    bookList: bloc.bookList,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
            InkWell(
              onTap: () {
                showSortingBottomSheet(context);
              },
              child: const Icon(
                Icons.sort,
                color: kWhiteTextColor,
              ),
            ),
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
                  showViewSelectBottomSheet(context);
                },
                child: buildIcon(selectedView),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showSortingBottomSheet(BuildContext context) {
    final bloc = Provider.of<ShelfDetailsBloc>(context, listen: false);

    return showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(kSP10x)),
        context: context,
        builder: (context) {
          return ListenableProvider.value(
            value: bloc,
            child: FractionallySizedBox(
              heightFactor: 0.5,
              child: Selector<ShelfDetailsBloc, String>(
                selector: (context, bloc) => bloc.selectedSortingStatus,
                builder: (context, selectedSortingStatus, _) => Padding(
                  padding: const EdgeInsets.all(kSP16x),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: kSP10x),
                        child: Text(
                          "Sort",
                          style: TextStyle(
                              color: kWhiteTextColor,
                              fontSize: kFontSize20x,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: sortingList.length,
                        itemBuilder: (context, index) {
                          final String sortingStatus = sortingList[index];
                          return InkWell(
                            onTap: () {
                              final bloc = context.read<ShelfDetailsBloc>();
                              bloc.sortBookBySortingStatus(sortingStatus);
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                Radio(
                                  visualDensity: VisualDensity.compact,
                                  groupValue: sortingStatus,
                                  value: selectedSortingStatus,
                                  onChanged: (Object? value) {
                                    final bloc =
                                        context.read<ShelfDetailsBloc>();
                                    bloc.sortBookBySortingStatus(sortingStatus);
                                    Navigator.pop(context);
                                  },
                                ),
                                Text(
                                  "Sort by $sortingStatus",
                                  style:
                                      const TextStyle(fontSize: kFontSize14x),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> showViewSelectBottomSheet(BuildContext context) {
    final bloc = Provider.of<ShelfDetailsBloc>(context, listen: false);

    return showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(kSP10x)),
        context: context,
        builder: (context) {
          return ListenableProvider.value(
            value: bloc,
            child: FractionallySizedBox(
              heightFactor: 0.5,
              child: Selector<ShelfDetailsBloc, String>(
                selector: (context, bloc) => bloc.selectedView,
                builder: (context, selectedView, _) => Padding(
                  padding: const EdgeInsets.all(kSP16x),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: kSP10x),
                        child: Text(
                          "View as",
                          style: TextStyle(
                              color: kWhiteTextColor,
                              fontSize: kFontSize20x,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: viewOptions.length,
                        itemBuilder: (context, index) {
                          final String view = viewOptions[index];
                          return InkWell(
                            onTap: () {
                              final bloc = context.read<ShelfDetailsBloc>();
                              bloc.changeView(view);
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                Radio(
                                  visualDensity: VisualDensity.compact,
                                  groupValue: selectedView,
                                  value: view,
                                  onChanged: (Object? value) {
                                    final bloc =
                                        context.read<ShelfDetailsBloc>();
                                    bloc.changeView(view);
                                    Navigator.pop(context);
                                  },
                                ),
                                Text(
                                  view,
                                  style:
                                      const TextStyle(fontSize: kFontSize14x),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
