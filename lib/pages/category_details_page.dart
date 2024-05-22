import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';

class CategoryDetailsPage extends StatelessWidget {
  const CategoryDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: const Text(
          "Title",
          style: TextStyle(color: kWhiteTextColor),
        ),
        leading: const BackButton(
          color: kWhiteTextColor,
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: kSP16x),
        child: BooksGridView(),
      ),
    );
  }
}

class BooksGridView extends StatefulWidget {
  const BooksGridView({
    super.key,
  });

  @override
  State<BooksGridView> createState() => _BooksGridViewState();
}

class _BooksGridViewState extends State<BooksGridView> {
  List<BookVO> books = [];
  @override
  void initState() {
    PlaybooksModel model = PlaybooksModel();

    model
        .getBooksByCategoryAndDate(
            "current", "combined-print-and-e-book-nonfiction")
        .then((value) {
      setState(() {
        books = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return books.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            itemCount: books.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 250,
              crossAxisSpacing: kSP5x,
              mainAxisSpacing: kSP10x,
            ),
            itemBuilder: (context, index) {
              final BookVO bookVO = books[index];
              return Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(kSP5x),
                    child: Image.network(
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        bookVO.bookImage ?? "")),
              );
            },
          );
  }
}
