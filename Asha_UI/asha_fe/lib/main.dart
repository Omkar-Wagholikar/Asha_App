import 'package:asha_fe/Constants/theme.dart';
import 'package:flutter/material.dart';
import 'MainPage/pages/search_page.dart';
import 'glass_morphic_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      // home: const SearchPage(),
      home: Stack(
        children: [
          Image.asset(
            "assets/images/v5.jpeg",
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
