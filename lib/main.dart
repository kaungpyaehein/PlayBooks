import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playbooks_flutter/data/bloc/create_new_shelf_bloc.dart';
import 'package:playbooks_flutter/data/bloc/shelf_bloc.dart';
import 'package:playbooks_flutter/data/bloc/books_bloc.dart';
import 'package:playbooks_flutter/data/vos/book_vo.dart';
import 'package:playbooks_flutter/data/vos/buy_link_vo.dart';
import 'package:playbooks_flutter/data/vos/isbn_vo.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/pages/indexed_page.dart';
import 'package:playbooks_flutter/persistence/hive_constants.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  /// Initialize hive
  await Hive.initFlutter();

  /// Register adapters
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(IsbnVOAdapter());
  Hive.registerAdapter(BuyLinkVOAdapter());
  Hive.registerAdapter(ShelfVOAdapter());

  /// Open Hive Box
  await Hive.openBox<BookVO>(kBoxNameBookVO);
  await Hive.openBox<ShelfVO>(kBoxNameShelfVO);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CreateNewShelfBloc>(
            create: (_) => CreateNewShelfBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: kPrimaryColor, brightness: Brightness.dark),
          scaffoldBackgroundColor: kBackgroundColor,
        ),
        home: const IndexedPage(),
      ),
    );
  }
}
