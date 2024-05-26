import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/bloc/carrousel_bloc.dart';
import 'package:playbooks_flutter/data/bloc/home_page_bloc.dart';
import 'package:playbooks_flutter/data/bloc/books_bloc.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/category_vo.dart';
import 'package:playbooks_flutter/pages/book_details_page.dart';
import 'package:playbooks_flutter/pages/category_details_page.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';
import 'package:playbooks_flutter/resources/strings.dart';
import 'package:provider/provider.dart';

import 'indexed_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: kSP20x,
                    ),
                  ),

                  /// Carrousel View
                  const CarrouselView(),

                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: kSP20x,
                    ),
                  ),

                  /// Choose Ebooks and Audio Books section
                  const SliverToBoxAdapter(
                    child: EbooksAndAudiobooksSelectorView(),
                  ),

                  /// Category View
                  Selector<HomePageBloc, String>(
                    builder: (context, selectedText, _) {
                      if (selectedText == kEbooksLabel) {
                        return const EbooksView();
                      }
                      return const AudioBooksView();
                    },
                    selector: (context, bloc) => bloc.selectedText,
                  )
                ],
              ),
              const SearchFieldView()
            ],
          ),
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
    return Selector<HomePageBloc, List<CategoryVO>>(
        selector: (context, bloc) => bloc.categoryList,
        builder: (_, categoryList, __) {
          if (categoryList.isEmpty) {
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: categoryList.length,
              (context, index) {
                final CategoryVO categoryVO = categoryList[index];
                return Column(
                  children: [
                    /// Category Title
                    CategoryTitleView(categoryVO: categoryVO),

                    /// Books List Horizontal Scroll View
                    BooksHorizontalView(
                      categoryVO: categoryVO,
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}

class CategoryTitleView extends StatelessWidget {
  const CategoryTitleView({
    super.key,
    required this.categoryVO,
  });

  final CategoryVO categoryVO;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailsPage(
                categoryVO: categoryVO,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: kSP20x, right: kSP16x, left: kSP20x, bottom: kSP16x),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                categoryVO.listName ?? "",
                style: const TextStyle(
                    color: kWhiteTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: kFontSize18x),
              ),
            ),
            const SizedBox(
              width: kSP40x,
            ),
            const Icon(
              Icons.arrow_forward,
              color: kPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}

class BooksHorizontalView extends StatelessWidget {
  const BooksHorizontalView({
    super.key,
    required this.categoryVO,
  });
  final CategoryVO categoryVO;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: kSP16x),
        itemCount: categoryVO.books!.length,
        itemBuilder: (context, index) {
          final BookVO bookVO = categoryVO.books![index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSP5x),
            child: BookItemView(
              bookVO: bookVO,
              isLargeGrid: false,
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class BookItemView extends StatelessWidget {
  const BookItemView({
    super.key,
    required this.bookVO,
    required this.isLargeGrid,
  });

  final BookVO bookVO;
  final bool isLargeGrid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailsPage(
                  bookVO: bookVO,
                ),
              ));
        },
        child: SizedBox(
          width: isLargeGrid ? 200 : 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Book Cover
              ClipRRect(
                borderRadius: BorderRadius.circular(kSP5x),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: bookVO.bookImage ?? "",
                  height: isLargeGrid ? 240 : 180,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: kSP10x,
              ),

              /// Title
              Text(
                bookVO.title ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: kWhiteTextColor,
                ),
              ),
              const SizedBox(
                height: kSP5x,
              ),

              // Author
              Text(
                bookVO.author ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: kGreyTextColor,
                ),
              )
            ],
          ),
        ));
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
  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, String>(
      selector: (_, bloc) => bloc.selectedText,
      builder: (_, selectedText, __) {
        final bloc = context.read<HomePageBloc>();
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
                  bloc.onTapEbooksAndAudioBooks(kEbooksLabel);
                },
                isSelected: selectedText == kEbooksLabel,
              ),
              EbookAudiobookButtonView(
                label: kAudioBooksLabel,
                onTapButton: () {
                  bloc.onTapEbooksAndAudioBooks(kAudioBooksLabel);
                },
                isSelected: selectedText == kAudioBooksLabel,
              ),
            ],
          ),
        );
      },
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
    return ChangeNotifierProvider(
      create: (context) => CarrouselBloc(),
      child: Selector<CarrouselBloc, List<BookVO>>(
        selector: (context, bloc) => bloc.bookList,
        builder: (context, bookList, _) {
          if (bookList.isNotEmpty) {
            return SliverToBoxAdapter(
              child: CarouselSlider(
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
                items: bookList.map((book) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailsPage(
                              bookVO: book,
                            ),
                          ));
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kSP8x),
                          child: CachedNetworkImage(
                            imageUrl: book.bookImage ?? "",
                            fit: BoxFit.cover,
                          ),
                        )),
                  );
                }).toList(),
              ),
            );
          }
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        },
      ),
    );
  }
}


