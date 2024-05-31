import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/bloc/category_details_bloc.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/category_vo.dart';
import 'package:playbooks_flutter/pages/home_page.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';
import 'package:provider/provider.dart';

class CategoryDetailsPage extends StatelessWidget {
  const CategoryDetailsPage({
    super.key,
    required this.categoryVO,
  });

  final CategoryVO categoryVO;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryDetailsBloc(categoryVO.listNameEncoded ?? ""),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          title: Text(
            categoryVO.listName ?? "",
            style: const TextStyle(
                color: kWhiteTextColor,
                fontWeight: FontWeight.w600,
                fontSize: kFontSize18x),
          ),
          leading: const BackButton(
            color: kWhiteTextColor,
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSP16x),
          child: Selector<CategoryDetailsBloc, List<BookVO>>(
            selector: (context, bloc) => bloc.bookList,
            builder: (context, bookList, child) {
              return BooksGridView(
                bookList: bookList,
              );
            },
          ),
        ),
      ),
    );
  }
}

class BooksGridView extends StatelessWidget {
  const BooksGridView({
    super.key,
    required this.bookList,
  });

  final List<BookVO> bookList;
  @override
  Widget build(BuildContext context) {
    return bookList.isEmpty
        ? const Center(
            child: SizedBox.shrink(),
          )
        : GridView.builder(
            itemCount: bookList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 300,
              crossAxisSpacing: kSP12x,
              mainAxisSpacing: kSP12x,
            ),
            itemBuilder: (context, index) {
              final BookVO bookVO = bookList[index];
              return BookItemView(
                bookVO: bookVO,
                isLargeGrid: true,
              );
            },
          );
  }
}
