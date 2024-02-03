import 'package:asha_fe/Constants/hive-boxes.dart';
import 'package:asha_fe/Constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'MainPage/pages/search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('entry');
  await Hive.openBox("bookmarks");
  HiveBoxes.box = Hive.box('entry');
  HiveBoxes.bookmarks = Hive.box("bookmarks");
  HiveBoxes.updatePDFAssetValues();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asha App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appTheme),
        useMaterial3: true,
      ),
      home: Stack(
        children: [
          Image.asset(
            "assets/images/asha_bg.jpeg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          const SearchPage(),
        ],
      ),
    );
  }
}
