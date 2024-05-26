import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/bloc/books_bloc.dart';
import 'package:playbooks_flutter/data/bloc/shelf_bloc.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/pages/book_details_page.dart';
import 'package:playbooks_flutter/pages/create_new_shelf_page.dart';
import 'package:playbooks_flutter/pages/home_page.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';
import 'package:playbooks_flutter/resources/strings.dart';
import 'package:provider/provider.dart';

class BooksView extends StatelessWidget {
  const BooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BooksBloc(),
      child: CustomScrollView(
        slivers: [
          /// CategoryList to choose
          Consumer<BooksBloc>(
            builder: (context, bloc, child) => CategoryList(
              categoryList: bloc.categories,
              onTapCategory: (category) {
                bloc.selectCategory(category);
              },
              selectedCategory: bloc.selectedCategory,
            ),
          ),

          /// Sort bya and Change Grid or List View
          const SortingAndLayoutChangeView(),

          /// Books View
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: kSP16x,
            ),
            sliver: Consumer<BooksBloc>(
              builder: (context, bloc, _) {
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
    );
  }
}

class TabsView extends StatelessWidget {
  const TabsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelPadding:
          const EdgeInsets.symmetric(horizontal: 30), // Space between tabs
      isScrollable: true,
      tabAlignment: TabAlignment.center,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: kPrimaryColor,
      labelStyle:
          const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
      unselectedLabelStyle:
          const TextStyle(color: kWhiteTextColor, fontWeight: FontWeight.w500),
      dividerColor: Colors.grey.shade800,
      tabs: const [
        Tab(
          text: "Your Books",
        ),
        Tab(
          text: "Your Shelves",
        ),
      ],
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categoryList,
    required this.selectedCategory,
    required this.onTapCategory,
  });

  final List<String> categoryList;
  final String selectedCategory;
  final void Function(String category) onTapCategory;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: kSP60x,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: kSP16x,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: FilterChip(
                backgroundColor: kTextFieldFillColor,
                selected: categoryList[index] == selectedCategory,
                // showCheckmark: categories[index] == bloc.selectedCategory,
                checkmarkColor: kPrimaryColor,

                label: Text(
                  categoryList[index],
                  style: const TextStyle(color: kWhiteTextColor),
                ),
                onSelected: (_) {
                  onTapCategory(categoryList[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class BooksListView extends StatelessWidget {
  const BooksListView({super.key, required this.bookList});

  final List<BookVO> bookList;
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: bookList.length,
            (context, index) {
      final BookVO bookVO = bookList[index];
      return InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BookDetailsPage(bookVO: bookVO),
        )),
        onLongPress: () {
          showAddToShelfBottomShelf(context, bookVO);
        },
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(kSP5x),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 100,
              width: 50,
              imageUrl: bookVO.bookImage ?? "",
            ),
          ),
          title: Text(
            bookVO.title ?? "",
            style: const TextStyle(color: kWhiteTextColor),
          ),
          subtitle: Text(
            bookVO.author ?? "",
            style: const TextStyle(color: kGreyTextColor),
          ),
          trailing: const Icon(
            Icons.download,
            color: kPrimaryColor,
          ),
        ),
      );
    }));
  }
}

Future<dynamic> showAddToShelfBottomShelf(BuildContext context, BookVO bookVO) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(kSP10x)),
    ),
    backgroundColor: kBackgroundColor, // Adjust background color if needed
    builder: (context) {
      return Selector<ShelfBloc, List<ShelfVO>>(
        selector: (context, bloc) => bloc.shelfList,
        builder: (context, shelfList, _) {
          return Padding(
            padding: const EdgeInsets.all(kSP16x),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: kSP10x),
                  child: Text(
                    "Add to shelf",
                    style: TextStyle(
                      color: kWhiteTextColor,
                      fontSize: kFontSize20x,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(),
                shelfList.isEmpty
                    ? Expanded(
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const CreateNewShelfPage(),
                              ));
                            },
                            child: const Text("Create New Shelf"),
                          ),
                        ),
                      )
                    : Flexible(
                        child: DraggableScrollableSheet(
                          initialChildSize: 1, // Adjust initial height
                          minChildSize: 1, // Adjust minimum height
                          maxChildSize: 1, // Adjust maximum height
                          builder: (context, scrollController) {
                            return ListView.builder(
                              controller: scrollController,
                              itemCount: shelfList.length,
                              itemBuilder: (context, index) {
                                final ShelfVO shelf = shelfList[index];
                                return ListTile(
                                  leading: shelf.bookList!.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            kSP10x,
                                          ),
                                          child: CachedNetworkImage(
                                            height: 100,
                                            width: 50,
                                            fit: BoxFit.cover,
                                            imageUrl: shelf.bookList!.first
                                                    .bookImage ??
                                                "",
                                          ),
                                        )
                                      : Container(
                                          height: 50,
                                          width: 50,
                                          color: kPrimaryColor,
                                        ),
                                  title: Text(
                                    shelf.shelfName ?? "",
                                    style:
                                        const TextStyle(color: kWhiteTextColor),
                                  ),
                                  subtitle: Text(
                                    "${shelf.bookList!.length.toString()} books",
                                    style:
                                        const TextStyle(color: kGreyTextColor),
                                  ),
                                  onTap: () {
                                    context
                                        .read<ShelfBloc>()
                                        .addNewBookToShelf(bookVO, shelf);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
              ],
            ),
          );
        },
      );
    },
  );
}

class BooksLargeGridView extends StatelessWidget {
  const BooksLargeGridView({
    super.key,
    required this.bookList,
  });
  final List<BookVO> bookList;
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: bookList.length,
        (context, index) {
          return InkWell(
            onLongPress: () {
              showAddToShelfBottomShelf(context, bookList[index]);
            },
            child: BookItemView(
              bookVO: bookList[index],
              isLargeGrid: true,
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 300,
        crossAxisSpacing: kSP10x,
        mainAxisSpacing: kSP12x,
      ),
    );
  }
}

class BooksSmallGridView extends StatelessWidget {
  const BooksSmallGridView({
    super.key,
    required this.bookList,
  });
  final List<BookVO> bookList;
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: bookList.length,
        (context, index) {
          return InkWell(
            onLongPress: () {
              showAddToShelfBottomShelf(context, bookList[index]);
            },
            child: BookItemView(
              bookVO: bookList[index],
              isLargeGrid: false,
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 240,
        crossAxisSpacing: kSP10x,
        mainAxisSpacing: kSP12x,
      ),
    );
  }
}

class SortingAndLayoutChangeView extends StatelessWidget {
  const SortingAndLayoutChangeView({
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
            Selector<BooksBloc, String>(
              selector: (context, bloc) => bloc.selectedSortingStatus,
              builder: (context, selectedSortingStatus, child) => InkWell(
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kSP10x)),
                    context: context,
                    builder: (_) => SortingBottomSheetView(
                      onTap: (sortingStatus) {
                        final bloc = context.read<BooksBloc>();
                        bloc.sortBookBySortingStatus(sortingStatus);
                        Navigator.pop(context);
                      },
                      selectedSortingStatus: selectedSortingStatus,
                    ),
                  );
                },
                child: const Icon(
                  Icons.sort,
                  color: kWhiteTextColor,
                ),
              ),
            ),
            const SizedBox(
              width: kSP10x,
            ),
            Selector<BooksBloc, String>(
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
            Selector<BooksBloc, String>(
              selector: (context, bloc) => bloc.selectedView,
              builder: (context, selectedView, child) => InkWell(
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kSP10x)),
                    context: context,
                    builder: (_) => ViewSelectBottomSheetView(
                      onChangeView: (view) {
                        final bloc = context.read<BooksBloc>();
                        bloc.changeView(view);
                        Navigator.pop(context);
                      },
                      selectedView: selectedView,
                    ),
                  );
                },
                child: buildIcon(selectedView),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildIcon(String selectedView) {
  switch (selectedView) {
    case kViewList:
      return const Icon(
        Icons.view_list_outlined,
        color: kWhiteTextColor,
      );
    case kViewLargeGrid:
      return const Icon(
        Icons.grid_view,
        color: kWhiteTextColor,
      );
    case kViewSmallGrid:
      return const Icon(
        Icons.grid_on_sharp,
        color: kWhiteTextColor,
      );
    default:
      return const Icon(
        Icons.error_outline,
        color: kWhiteTextColor,
      );
  }
}

class SortingBottomSheetView extends StatelessWidget {
  const SortingBottomSheetView({
    super.key,
    required this.selectedSortingStatus,
    required this.onTap,
  });

  final String selectedSortingStatus;
  final void Function(String selectedStatus) onTap;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Padding(
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
                    onTap(sortingStatus);
                  },
                  child: Row(
                    children: [
                      Radio(
                        visualDensity: VisualDensity.compact,
                        groupValue: sortingStatus,
                        value: selectedSortingStatus,
                        onChanged: (Object? value) {
                          onTap(sortingStatus);
                        },
                      ),
                      Text(
                        "Sort by $sortingStatus",
                        style: const TextStyle(fontSize: kFontSize14x),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ViewSelectBottomSheetView extends StatelessWidget {
  const ViewSelectBottomSheetView({
    super.key,
    required this.selectedView,
    required this.onChangeView,
  });

  final String selectedView;
  final void Function(String selectedView) onChangeView;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Padding(
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
                    onChangeView(view);
                  },
                  child: Row(
                    children: [
                      Radio(
                        visualDensity: VisualDensity.compact,
                        groupValue: selectedView,
                        value: view,
                        onChanged: (Object? value) {
                          onChangeView(view);
                        },
                      ),
                      Text(
                        view,
                        style: const TextStyle(fontSize: kFontSize14x),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
