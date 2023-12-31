import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../Constants/theme.dart';
import '../pdf_page_with_nav.dart';
import '../Utils/networking.dart';

class AshaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarText;
  final String appBarIconPath;

  const AshaAppBar(
      {super.key, required this.appBarText, required this.appBarIconPath});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      backgroundColor: AppColors.appBar,
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Image.asset(appBarIconPath),
      ),
      title: Text(
        appBarText,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 34,
            color: AppColors.fontLight,
            fontFamily: "opensans light"),
      ),
      actions: const [
        PopUpWidget(),
      ],
    );
  }
}

class PopUpWidget extends StatelessWidget {
  const PopUpWidget({super.key});

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
        PopupMenuItem(
          value: 2,
          // row with 2 children
          child: Row(
            children: [
              Icon(AppIcons.updateLinkPopUp),
              const SizedBox(
                width: 10,
              ),
              const Text("Update Link")
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
      ],
      offset: const Offset(0, 100),
      color: AppColors.iconsLightTheme,
      elevation: 4,
      // on selected we show the dialog box
      onSelected: (value) {
        // if value 1 show dialog
        if (value == 1) {
          _showPdfPage(context);
        } else if (value == 2) {
          print("Updating links");
          _showLinkUpdate(context);
          // if value 2 show dialog
        } else if (value == 3) {
          print("Reporting errors");
          _showReportError(context);
        }
      },
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
                  log(linkController.text + "saved");
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
