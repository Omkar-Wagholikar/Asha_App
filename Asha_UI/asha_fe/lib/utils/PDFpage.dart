import 'dart:async';
import 'package:asha_fe/Components/BottomNavBar.dart';
import 'package:asha_fe/Components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFpage extends StatelessWidget {
  final String path;
  const PDFpage({super.key, required this.path});
  @override
  Widget build(BuildContext context) {
    print(path);
    if (path.isNotEmpty) {
      return Scaffold(
        appBar: const AshaAppBar(
          appBarIconPath: "assets/images/PKC-logo.png",
          appBarText: 'PDF page',
        ),
        body: SfPdfViewer.asset("assets/pdfs/$path.pdf"),
        bottomNavigationBar: AshaBottomNavBar(),
      );
    }
    return const Placeholder();
  }
}
