import 'dart:io';

import 'package:flutter/services.dart';

import '../../Utils/networking.dart';

class PdfModel {
  final String fileName;
  late final String filePath;
  late bool isAsset;

  final possibleDownloadsDirectory =
      "/storage/emulated/0/Android/data/com.example.asha_fe/files/data/user/0/com.example.asha_fe/files/";

  PdfModel({required this.fileName}) {
    print("PdfModel object constructed for $fileName");
    isAsset = false;
  }

  Future<void> setFilePath() async {
    print("checking file path");
    if (fileName == "") {
      filePath = "";
      print("File name is empty");
      return;
    }
    if (await isLocal("assets/pdfs/$fileName.pdf")) {
      // // local sync fusion rendering
      //print("$fileName is present in the assets");
      isAsset = true;
      filePath = "assets/pdfs/$fileName.pdf";
    } else if (await isDownloaded()) {
      // //check downloads folder
      // print("$fileName is present in the downloads folder");
      filePath = "$possibleDownloadsDirectory$fileName.pdf";
    } else {
      // // downloading
      // print("$fileName is not in downloads or assets, starting download");
      filePath = await Networking.downloadPDFtoFilePath(fileName);
      // print("PDF DOWNLOADED TO PATH: $filePath");
      // print("Download complete");
    }
    print("final value for filePath is: $filePath");
  }

  Future<bool> isDownloaded() async {
    String potentialPath = "$possibleDownloadsDirectory$fileName.pdf";
    print("Checking Validity of $potentialPath");
    if (await File(potentialPath).exists()) {
      return true;
    }
    return false;
  }

  Future<bool> isLocal(String filePath) async {
    return await rootBundle
        .load(filePath)
        .then((_) => true)
        .catchError((_) => false);
  }

  String nextPdf(bool nextPage) {
    if (fileName == "") return "";
    List<String> temp = fileName.split('-');
    if (nextPage) {
      if (temp.length == 5) {
        // print(
        //     ">${temp[0]}-${temp[1]}-${temp[2]}-page-${1 + int.parse(temp[4])}");
        return "${temp[0]}-${temp[1]}-${temp[2]}-page-${1 + int.parse(temp[4])}";
      } else {
        return "${temp[0]}-${temp[1]}-${1 + int.parse(temp[2].split('.')[0])}";
      }
    } else {
      if (temp.length == 5) {
        // print(
        //     ">${temp[0]}-${temp[1]}-${temp[2]}-page-${int.parse(temp[4]) - 1}");
        return "${temp[0]}-${temp[1]}-${temp[2]}-page-${int.parse(temp[4]) - 1}";
      } else {
        return "${temp[0]}-${temp[1]}-${int.parse(temp[2].split('.')[0]) - 1}";
      }
    }
  }

  factory PdfModel.fromJson(Map<String, dynamic> json) {
    return PdfModel(fileName: json['fileName']);
  }

  Map<String, dynamic> toJson() {
    return {'fileName': fileName};
  }
}
