import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:playbooks_flutter/data/bloc/create_new_shelf_bloc.dart';
import 'package:playbooks_flutter/data/bloc/shelf_bloc.dart';
import 'package:playbooks_flutter/data/bloc/your_books_bloc.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/pages/book_details_page.dart';
import 'package:playbooks_flutter/pages/create_new_shelf_page.dart';
import 'package:playbooks_flutter/pages/home_page.dart';
import 'package:playbooks_flutter/pages/indexed_page.dart';
import 'package:playbooks_flutter/pages/your_shelf_view.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';
import 'package:playbooks_flutter/resources/enums.dart';
import 'package:playbooks_flutter/resources/strings.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: true,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverAppBar(
              backgroundColor: kBackgroundColor,
              titleSpacing: 0,
              title: SearchFieldView(),
            ),
          ],
          body: const DefaultTabController(
            length: 2,
            child: Column(
              children: [
                /// Tabs View
                TabsView(),

                /// TabBar View
                Expanded(
                  child: TabBarView(
                    children: [
                      /// Your Books View
                      YourBooksView(),

                      /// Your Shelf View
                      YourShelfView()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class YourBooksView extends StatelessWidget {
  const YourBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        /// CategoryList to choose
        const CategoryList(),

        /// Sort bya and Change Grid or List View
        const SortingAndLayoutChangeView(),

        /// Books View
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: kSP16x,
          ),
          sliver: Consumer<YourBooksBloc>(
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
  });

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
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: FilterChip(
                backgroundColor: kTextFieldFillColor,
                selected: index % 3 == 0,
                showCheckmark: false,
                selectedColor: kSecondaryColor,
                selectedShadowColor: kPrimaryColor,
                label: Text(
                  "Item $index",
                  style: const TextStyle(color: kWhiteTextColor),
                ),
                onSelected: (value) {},
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
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 260,
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
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 260,
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
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kSP10x)),
                  context: context,
                  builder: (context) => const SortingBottomSheetView(),
                );
              },
              child: const Icon(
                Icons.sort,
                color: kWhiteTextColor,
              ),
            ),
            const SizedBox(
              width: kSP10x,
            ),
            Selector<YourBooksBloc, String>(
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
            Selector<YourBooksBloc, String>(
              selector: (context, bloc) => bloc.selectedView,
              builder: (context, selectedView, child) => InkWell(
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kSP10x)),
                    context: context,
                    builder: (context) => const ViewSelectBottomSheetView(),
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
  });

  @override
  Widget build(BuildContext context) {
    List<String> sortingList = [kSortingRecent, kSortingAuthor, kSortingTitle];
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Selector<YourBooksBloc, String>(
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
                      final bloc = context.read<YourBooksBloc>();
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
                            final bloc = context.read<YourBooksBloc>();
                            bloc.sortBookBySortingStatus(sortingStatus);
                            Navigator.pop(context);
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
      ),
    );
  }
}

class ViewSelectBottomSheetView extends StatelessWidget {
  const ViewSelectBottomSheetView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Selector<YourBooksBloc, String>(
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
                      final bloc = context.read<YourBooksBloc>();
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
                            final bloc = context.read<YourBooksBloc>();
                            bloc.changeView(view);
                            Navigator.pop(context);
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
      ),
    );
  }
}
