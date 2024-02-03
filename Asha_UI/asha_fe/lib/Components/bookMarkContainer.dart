import 'package:flutter/material.dart';

import '../Constants/hive-boxes.dart';
import '../PdfPage/pages/pdf_page.dart';

class BookMarkEntry extends StatelessWidget {
  final String query;
  final String pageName;

  const BookMarkEntry({
    Key? key,
    required this.query,
    required this.pageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(query),
        subtitle: Text(pageName),
      ),
      onTap: () {
        var entry = HiveBoxes.box?.get(pageName);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PdfPage(query: query, fileName: entry["fileName"])));
      },
    );
  }
}
