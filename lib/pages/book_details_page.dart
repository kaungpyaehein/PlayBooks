import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/model/playbooks_model.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({super.key, required this.bookVO});

  final BookVO bookVO;

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  void initState() {
    PlaybooksModel().addBookToDatabase(widget.bookVO);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: kSP16x, vertical: kSP16x),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(kSP8x),
                  child: CachedNetworkImage(
                    height: 220,
                    width: 150,
                    fit: BoxFit.cover,
                    imageUrl: widget.bookVO.bookImage ?? "",
                  ),
                ),
                const SizedBox(
                  width: kSP12x,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bookVO.title ?? "",
                        maxLines: 3,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: kFontSize18x,
                        ),
                      ),
                      Text(
                        widget.bookVO.author ?? "",
                        style: const TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.bookVO.publisher ?? "",
                        style: const TextStyle(
                            color: kWhiteTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.bookVO.categoryName ?? "",
                        style: const TextStyle(
                            color: kWhiteTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kSP12x),
              child: Divider(),
            ),
            Row(
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kWhiteTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kSP8x),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Free Sample",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: kPrimaryColor),
                  ),
                ),
                const SizedBox(
                    width: 8.0), // Add some space between the buttons
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kSP8x),
                      ),
                    ),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_add_rounded,
                        ),
                        SizedBox(
                          width: kSP10x,
                        ),
                        Text(
                          "Add to wishlist",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kSP12x,
            ),
            const Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: kGreyTextColor,
                ),
                SizedBox(
                  width: kSP10x,
                ),
                Expanded(
                  child: Text(
                      "The books that you buy on Google Play website can be read in this app"),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kSP12x),
              child: Divider(),
            ),
            ExpansionTile(
              shape: const Border(),
              title: const Text(
                "About this ebook",
                style: TextStyle(
                  color: kWhiteTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                widget.bookVO.description ?? "",
                maxLines: 1,
                style: const TextStyle(
                  color: kWhiteTextColor,
                  fontSize: kFontSize14x,
                ),
              ),
              children: [
                Text(
                  widget.bookVO.description ?? "",
                  style: const TextStyle(
                    color: kWhiteTextColor,
                    fontSize: kFontSize14x,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kSP10x,
            ),
          ],
        ),
      ),
    );
  }
}
