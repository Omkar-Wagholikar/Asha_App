import 'package:asha_fe/AboutPage/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../Constants/theme.dart';
import '../pdf_page_with_nav.dart';
import '../Utils/networking.dart';

class AshaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarText = 'ASHA ';
  final String appBarTextHindi = 'साथी';
  final String appBarIconPath = 'assets/images/PKC-logo.png';
  final double vertIconPadding = 2;
  final double horiIconPadding = 8;
  const AshaAppBar(
      // appBarText: 'Asha App',
      // appBarIconPath: "assets/images/PKC-logo.png"
      {super.key});
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
        //crossAxisAlignment: CrossAxisAlignment.center,
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
        // PopupMenuItem 1
        PopupMenuItem(
          value: 1,
          // row with two children
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
        // PopupMenuItem(
        //   value: 2,
        //   // row with 2 children
        //   child: Row(
        //     children: [
        //       Icon(AppIcons.updateLinkPopUp),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       const Text("Update Link")
        //     ],
        //   ),
        // ),
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
      // on selected we show the dialog box
      onSelected: (value) {
        if (value == 1) {
          // if value 1 show dialog
          _showPdfPage(context);
        } else if (value == 2) {
          // Updating links
          // _showLinkUpdate(context);

          // Saved links and pages
          _showBookMarks(context);
        } else if (value == 3) {
          // Reporting error
          print("Reporting errors");
          _showReportError(context);
        } else if (value == 4) {
          //show about page
          _showAboutPage(context);
        }
      },
    );
  }

  void _showBookMarks(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Work in progress"),
          );
        });
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

  void _showLinkUpdate(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController linkController = TextEditingController();
        return AlertDialog(
          title: const Text("Enter Link"),
          content: TextField(
            controller: linkController,
          ),
          actions: [
            MaterialButton(
              child: const Text("OK"),
              onPressed: () async {
                if (linkController.text != "") {
                  final LocalStorage storage = LocalStorage('url.json');
                  await storage.setItem('_url', linkController.text);
                  print("${linkController.text}saved");
                  Navigator.of(context).pop();
                } else {
                  linkController.text = "please provide link";
                }
              },
            ),
          ],
        );
      },
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
                  print(errorController.text + "saved");
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
