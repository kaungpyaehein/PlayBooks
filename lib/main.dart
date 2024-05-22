import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/buy_link_vo.dart';
import 'package:playbooks_flutter/data/vos/isbn_vo.dart';
import 'package:playbooks_flutter/network/api/playbooks_api.dart';
import 'package:playbooks_flutter/network/api_constants.dart';
import 'package:playbooks_flutter/pages/indexed_page.dart';
import 'package:playbooks_flutter/persistence/hive_constants.dart';

void main() async {
  /// Initialize hive
  await Hive.initFlutter();

  /// Register adapters
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(IsbnVOAdapter());
  Hive.registerAdapter(BuyLinkVOAdapter());

  /// Open Hive Box
  await Hive.openBox<BookVO>(kBoxNameBookVO);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: const IndexedPage(),
    );
  }
}
