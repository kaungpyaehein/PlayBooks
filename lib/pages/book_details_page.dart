import 'package:flutter/material.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({super.key});

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
                Container(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(kSP8x)),
                ),
                const SizedBox(
                  width: kSP12x,
                ),
                const Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Google Play Books & Audiobooks",
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: kFontSize18x,
                        ),
                      ),
                      Text(
                        "Martha Wells",
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Ebook",
                        style: TextStyle(
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
            InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const CategoryDetailsPage(),
                //     ));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "About this ebook",
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
            const SizedBox(
              height: kSP10x,
            ),
            const Text(
              "Jack Audley has been a highwayman.A soldier. And he has always been a rogue. What he is not, and never wanted to be, is a peer of the realm, responsible for an ancient heritage and the livelihood of hundreds. But when he is recognized as the long-lost son of the House of Wyndham, his carefree life is over.",
              maxLines: 5,
              style: TextStyle(
                color: kWhiteTextColor,
                fontSize: kFontSize14x,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
