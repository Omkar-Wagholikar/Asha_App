import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../../Constants/hive-boxes.dart';
import '../../Utils/networking.dart';

class PdfModel {
  final String fileName;
  late final String filePath;
  late bool isAsset;

  var stacklog = Logger(
    printer: PrettyPrinter(),
  );

  var log = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  final possibleDownloadsDirectory =
      "/storage/emulated/0/Android/data/com.example.asha_fe/files/data/user/0/com.example.asha_fe/files/";

  PdfModel({required this.fileName}) {
    log.i("PdfModel object constructed for $fileName");
    isAsset = false;
  }

  Future<void> setFilePath() async {
    if (fileName == "") {
      filePath = "";
      log.i("File name is empty");
      return;
    }

    var checker = HiveBoxes.box?.get(fileName);
    if (checker != null) {
      filePath = checker['filePath'];
      isAsset = checker['isAsset'];
    } else {
      filePath = await Networking.downloadPDFtoFilePath(fileName);
      isAsset = false;
      HiveBoxes.box?.put(fileName,
          {"fileName": fileName, "filePath": filePath, "isAsset": isAsset});
    }

    log.t(HiveBoxes.box?.get(fileName));
  }

  Future<bool> isDownloaded() async {
    String potentialPath = "$possibleDownloadsDirectory$fileName.pdf";
    log.i("Checking Validity of $potentialPath");
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
        return "${temp[0]}-${temp[1]}-${temp[2]}-page-${1 + int.parse(temp[4])}";
      } else {
        return "${temp[0]}-${temp[1]}-${1 + int.parse(temp[2].split('.')[0])}";
      }
    } else {
      if (temp.length == 5) {
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
