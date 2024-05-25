import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:playbooks_flutter/network/api/playbooks_api.dart';
import 'package:playbooks_flutter/network/api_constants.dart';
import 'package:playbooks_flutter/pages/home_page.dart';
import 'package:playbooks_flutter/pages/library_page.dart';
import 'package:playbooks_flutter/pages/shop_page.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';

class IndexedPage extends StatefulWidget {
  const IndexedPage({super.key});

  @override
  State<IndexedPage> createState() => _IndexedPageState();
}

class _IndexedPageState extends State<IndexedPage> {
  List<Widget> pages = [
    const HomePage(),
    const LibraryPage(),
    const ShopPage(),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    // PlaybooksApi(Dio()).getAllCategoriesByDate(kApiKey).then((value) {
    //   print(value.toString());
    //   PlaybooksApi(Dio())
    //       .getBooksByCategoryAndDate(
    //           kApiKey, "current", "combined-print-and-e-book-nonfiction")
    //       .then((thiss) {
    //     print(thiss.toString());
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: pages.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[kBottomNavigationBoxShow],
        ),
        child: BottomNavigationBar(
          backgroundColor: kBackgroundColor,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: kBottomNavUnselectedColor,
          selectedItemColor: kPrimaryColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: "Library",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: "Shop",
            ),
          ],
        ),
      ),
    );
  }
}

class SearchFieldView extends StatelessWidget {
  const SearchFieldView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSP16x),
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: "Search Play Books",
          fillColor: kTextFieldFillColor,
          filled: true,
          contentPadding: EdgeInsets.zero,
          hintStyle: const TextStyle(
              color: kTextFieldHintTextColor, fontSize: kFontSize16x),
          prefixIcon: const Icon(
            Icons.search,
            size: kSP23x,
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kSP40x),
              child: CachedNetworkImage(
                height: kSP23x,
                width: kSP23x,
                fit: BoxFit.cover,
                imageUrl:
                    "https://is1-ssl.mzstatic.com/image/thumb/DoYfxrZ6E9WrFy8TLhOmsQ/1200x675mf.jpg",
              ),
            ),
          ),
          prefixIconColor: kTextFieldHintTextColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kSP8x),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kSP8x),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
