import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'Components/appbar.dart';

class PdfPageWithNav extends StatefulWidget {
  final String name;
  const PdfPageWithNav({super.key, required this.name});

  @override
  State<PdfPageWithNav> createState() => _PdfPageWithNavState();
}

class _PdfPageWithNavState extends State<PdfPageWithNav> {
  int _selectedIndex = 0;
  String currPdf = "error";

  @override
  void initState() {
    super.initState();
    currPdf = newPdfname("", true); // Initialize currPdf in initState
    print("newly build $currPdf");
  }

  String newPdfname(String currPdf, bool nextPage) {
    if (currPdf == "") return widget.name;
    List<String> temp = currPdf.split('-');
    if (nextPage) {
      if (temp.length == 4) {
        return "${temp[0]}-${temp[1]}-${temp[2]}${1 + int.parse(temp[3])}";
      } else {
        return "${temp[0]}-${temp[1]}-${temp[2]}-${temp[3]}-${1 + int.parse(temp[4].split('.')[0])}";
      }
    } else {
      if (temp.length == 4) {
        return "${temp[0]}-${temp[1]}-${temp[2]}${int.parse(temp[3]) - 1}";
      } else {
        return "${temp[0]}-${temp[1]}-${temp[2]}-${temp[3]}-${int.parse(temp[4].split('.')[0]) - 1}";
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        currPdf = newPdfname(currPdf, false);
        print("Next page $currPdf");
      } else {
        currPdf = newPdfname(currPdf, true);
        print("previous page $currPdf");
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AshaAppBar(),
      body: Center(
        // child: Text(currPdf),
        child: SfPdfViewer.asset("assets/pdfs/$currPdf.pdf"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            label: 'Previous',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward_ios_rounded),
            label: 'Next',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
