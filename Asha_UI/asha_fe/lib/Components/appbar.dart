import 'package:asha_fe/AboutPage/pages/about_page.dart';
import 'package:asha_fe/Constants/hive-boxes.dart';
import 'package:flutter/material.dart';
import '../Constants/theme.dart';
import '../pdf_page_with_nav.dart';
import '../Utils/networking.dart';
import 'bookMarkContainer.dart';

class AshaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarText = 'ASHA ';
  final String appBarTextHindi = 'साथी';
  final String appBarIconPath = 'assets/images/PKC-logo.png';
  final double vertIconPadding = 2;
  final double horiIconPadding = 8;
  const AshaAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      backgroundColor: AppColors.appBar,
      leading: Padding(
        padding: EdgeInsets.fromLTRB(
            horiIconPadding, vertIconPadding, vertIconPadding, horiIconPadding),
        child: Image.asset(appBarIconPath),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appBarText,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                // fontSize: ,
                color: AppColors.fontLight,
                fontFamily: "opensans light"),
          ),
          Text(
            appBarTextHindi,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "opensans light",
              color: AppColors.fontLight,
            ),
          ),
        ],
      ),
      actions: const [
        PopUpMenuWidget(),
      ],
    );
  }
}

class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(AppIcons.readPdfs),
              const SizedBox(
                width: 10,
              ),
              const Text("Read PDF's")
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(AppIcons.bookmarkedPages),
              const SizedBox(
                width: 10,
              ),
              const Text("Saved pages")
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Icon(AppIcons.errorPopUp),
              const SizedBox(
                width: 10,
              ),
              const Text("Report error")
            ],
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Row(
            children: [
              Icon(AppIcons.aboutPage),
              const SizedBox(
                width: 10,
              ),
              const Text("About Page")
            ],
          ),
        ),
      ],
      offset: const Offset(0, 100),
      color: AppColors.iconsLightTheme,
      elevation: 4,
      onSelected: (value) {
        if (value == 1) {
          _showPdfPage(context);
        } else if (value == 2) {
          _showBookMarks(context);
        } else if (value == 3) {
          _showReportError(context);
        } else if (value == 4) {
          _showAboutPage(context);
        }
      },
    );
  }

  void _showBookMarks(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List? allEntries = HiveBoxes.bookmarks?.toMap().entries.toList();
        return SimpleDialog(
          title: const Text('Bookmarks'),
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: ListView.builder(
                itemCount: allEntries?.length,
                itemBuilder: (context, index) {
                  return BookMarkEntry(
                    query: allEntries?[index].value['query'],
                    pageName: allEntries?[index].key,
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showAboutPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutPage()),
    );
  }

  void _showPdfPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const PdfPageWithNav(name: "book-no-2-page-12")),
    );
  }

  void _showReportError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController errorController = TextEditingController();
        return AlertDialog(
          title: const Text("Please enter error"),
          content: TextField(
            controller: errorController,
          ),
          actions: [
            MaterialButton(
              child: const Text("OK"),
              onPressed: () async {
                if (errorController.text != "") {
                  Networking.reportError(errorController.text);
                  Navigator.of(context).pop();
                } else {
                  errorController.text = "please provide link";
                }
              },
            ),
          ],
        );
      },
    );
  }
}
