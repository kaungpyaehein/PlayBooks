import 'package:flutter/material.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Text(
          "Coming Soon",
          style: TextStyle(color: kWhiteTextColor, fontSize: kFontSize18x),
        ),
      ),
    );
  }
}
