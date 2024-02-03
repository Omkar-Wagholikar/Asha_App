import 'dart:io';

import 'package:asha_fe/Constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPdf extends StatelessWidget {
  final String filePath;
  final bool isAsset;
  const ShowPdf({super.key, required this.filePath, required this.isAsset});

  @override
  Widget build(BuildContext context) {
    return SfPdfViewerTheme(
        data: SfPdfViewerThemeData(
          progressBarColor: AppColors.fontLight,
          backgroundColor: Colors.transparent,
        ),
        child: isAsset
            ? SfPdfViewer.asset(
                filePath,
                onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                  showErrorDialog(context, details.error, details.description);
                },
              )
            : SfPdfViewer.file(
                File(filePath),
                onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                  showErrorDialog(context, details.error, details.description);
                },
              ));
  }

  void showErrorDialog(BuildContext context, String error, String description) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(error),
            content: Text(description),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
