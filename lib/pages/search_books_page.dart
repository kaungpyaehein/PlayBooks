import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/bloc/search_book_bloc.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/pages/category_details_page.dart';
import 'package:playbooks_flutter/pages/home_page.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';
import 'package:provider/provider.dart';

class SearchBookPage extends StatelessWidget {
  const SearchBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchBookBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const SearchField(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSP16x),
          child: Selector<SearchBookBloc, List<BookVO>>(
              builder: (context, resultBookList, child) {
                return BooksGridView(
                  bookList: resultBookList,
                );
              },
              selector: (context, bloc) => bloc.resultBookList),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SearchBookBloc>();

    return TextField(
      onSubmitted: (query) {
        bloc.queryStreamController.sink.add(query);
      },
      autofocus: true,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: "Search Play Books",
        fillColor: kTextFieldFillColor,
        contentPadding: EdgeInsets.zero,
        hintStyle: const TextStyle(
            color: kTextFieldHintTextColor, fontSize: kFontSize16x),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSP8x),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kSP8x),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
