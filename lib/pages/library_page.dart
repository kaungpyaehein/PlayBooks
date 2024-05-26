import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/bloc/shelf_bloc.dart';
import 'package:playbooks_flutter/data/bloc/books_bloc.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/pages/book_details_page.dart';
import 'package:playbooks_flutter/pages/books_view.dart';
import 'package:playbooks_flutter/pages/create_new_shelf_page.dart';
import 'package:playbooks_flutter/pages/home_page.dart';
import 'package:playbooks_flutter/pages/indexed_page.dart';
import 'package:playbooks_flutter/pages/shelf_list.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';
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
                      BooksView(),

                      /// Your Shelf View
                      ShelfListView()
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
