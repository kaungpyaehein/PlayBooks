import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:playbooks_flutter/pages/book_details_page.dart';
import 'package:playbooks_flutter/pages/category_details_page.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';
import 'package:playbooks_flutter/resources/strings.dart';

import 'indexed_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: kSP20x,
                  ),
                ),

                /// Carrousel View
                SliverToBoxAdapter(
                  child: CarrouselView(),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: kSP20x,
                  ),
                ),

                /// Choose Ebooks and Audio Books section
                SliverToBoxAdapter(
                  child: EbooksAndAudiobooksSelectorView(),
                ),

                /// Category View
                EbooksView()
              ],
            ),
            SearchFieldView()
          ],
        ),
      ),
    );
  }
}

class AudioBooksView extends StatelessWidget {
  const AudioBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text(
          "No Audiobooks for now!",
          style: TextStyle(color: kWhiteTextColor, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class EbooksView extends StatelessWidget {
  const EbooksView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 10,
        (context, index) {
          return Column(
            children: [
              /// Category Title
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryDetailsPage(),
                      ));
                },
                child: const Padding(
                  padding: EdgeInsets.only(
                      top: kSP20x, right: kSP16x, left: kSP16x, bottom: kSP16x),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          " Fantasy",
                          style: TextStyle(
                              color: kWhiteTextColor,
                              fontWeight: FontWeight.w500,
                              fontSize: kFontSize18x),
                        ),
                      ),
                      SizedBox(
                        width: kSP40x,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: kPrimaryColor,
                      )
                    ],
                  ),
                ),
              ),

              /// Books List Horizontal Scroll View
              SizedBox(
                height: 200,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: kSP16x),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookDetailsPage(),
                            ));
                      },
                      child: Container(
                          width: 140,
                          height: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(kSP10x)),
                          child: Center(
                            child: Text(
                              'text $index',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          )),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class EbooksAndAudiobooksSelectorView extends StatefulWidget {
  const EbooksAndAudiobooksSelectorView({
    super.key,
  });

  @override
  State<EbooksAndAudiobooksSelectorView> createState() =>
      _EbooksAndAudiobooksSelectorViewState();
}

class _EbooksAndAudiobooksSelectorViewState
    extends State<EbooksAndAudiobooksSelectorView> {
  String selectedLabel = kEbooksLabel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kTextFieldFillColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          EbookAudiobookButtonView(
            label: kEbooksLabel,
            onTapButton: () {
              setState(() {
                selectedLabel = kEbooksLabel;
              });
            },
            isSelected: selectedLabel == kEbooksLabel,
          ),
          EbookAudiobookButtonView(
            label: kAudioBooksLabel,
            onTapButton: () {
              setState(() {
                selectedLabel = kAudioBooksLabel;
              });
            },
            isSelected: selectedLabel == kAudioBooksLabel,
          ),
        ],
      ),
    );
  }
}

class EbookAudiobookButtonView extends StatelessWidget {
  const EbookAudiobookButtonView({
    super.key,
    required this.onTapButton,
    required this.isSelected,
    required this.label,
  });

  final Function() onTapButton;
  final bool isSelected;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapButton,
      child: Padding(
        padding: const EdgeInsets.only(
          top: kSP10x,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected ? kPrimaryColor : kWhiteTextColor,
                fontSize: kFontSize16x,
              ),
            ),
            const SizedBox(
                height: kSP8x), // Ensure there's space for the Divider
            Container(
              width: 70,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isSelected ? kPrimaryColor : Colors.transparent)),
            ),
          ],
        ),
      ),
    );
  }
}

class CarrouselView extends StatelessWidget {
  const CarrouselView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: CarouselController(),
      options: CarouselOptions(
        height: kCarouselSliderHeight,
        aspectRatio: 16 / 9,
        viewportFraction: 0.5,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.22,
        scrollDirection: Axis.horizontal,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(kSP10x)),
            child: Center(
              child: Text(
                'text $i',
                style: const TextStyle(fontSize: 16.0),
              ),
            ));
      }).toList(),
    );
  }
}

class BooksGridView extends StatelessWidget {
  const BooksGridView({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder widget, replace with actual implementation
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
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
    );
  }
}
