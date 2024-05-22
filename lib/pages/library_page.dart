import 'package:flutter/material.dart';
import 'package:playbooks_flutter/pages/indexed_page.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';

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

class YourShelfView extends StatelessWidget {
  const YourShelfView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                height: 100,
                width: 50,
                decoration: const BoxDecoration(color: Colors.yellow),
              ),
              title: const Text(
                "Book Name",
                style: TextStyle(color: kWhiteTextColor),
              ),
              subtitle: const Text(
                "this is subtitle",
                style: TextStyle(color: kGreyTextColor),
              ),
              trailing: const Icon(
                Icons.download,
                color: kPrimaryColor,
              ),
            );
          },
        ),
        Positioned(
          bottom: kSP16x,
          right: kSP16x,
          child: FloatingActionButton.extended(
            backgroundColor: kSecondaryColor,
            label: const Text(
              "Create New",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            isExtended: true,
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

class YourBooksView extends StatelessWidget {
  const YourBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        /// CategoryList to chosse
        CategoryList(),

        /// Sort bya and Change Grid or List View
        SortingAndLayoutChangeView(),

        /// Books View
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: kSP16x,
          ),
          sliver: BooksListView(),
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
  const BooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: 100, (context, index) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 100,
          width: 50,
          decoration: const BoxDecoration(color: Colors.yellow),
        ),
        title: const Text(
          "Book Name",
          style: TextStyle(color: kWhiteTextColor),
        ),
        subtitle: const Text(
          "this is subtitle",
          style: TextStyle(color: kGreyTextColor),
        ),
        trailing: const Icon(
          Icons.download,
          color: kPrimaryColor,
        ),
      );
    }));
  }
}

class BookGridView extends StatelessWidget {
  const BookGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: 100,
        (context, index) {

          return Container(
            color: Colors.blueGrey,
            child: Center(
              child: Text(
                'Book $index',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
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
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kSP16x, vertical: kSP10x),
        child: Row(
          children: [
            Icon(
              Icons.sort,
              color: kWhiteTextColor,
            ),
            SizedBox(
              width: kSP10x,
            ),
            Text(
              "Sort By",
              style: TextStyle(
                  color: kWhiteTextColor, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(
              Icons.view_list_outlined,
              color: kWhiteTextColor,
            )
          ],
        ),
      ),
    );
  }
}
