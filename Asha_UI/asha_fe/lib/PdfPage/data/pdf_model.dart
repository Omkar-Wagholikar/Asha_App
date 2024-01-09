import 'package:flutter/services.dart';

class PdfModel {
  final String fileName;
  late final String filePath;

  PdfModel({required this.fileName}) {
    print("PdfModel object constructed for $fileName");
    filePath = "assets/pdfs/$fileName.pdf";
  }

  Future<bool> isLocal() async {
    return await rootBundle
        .load(filePath)
        .then((_) => true)
        .catchError((_) => false);
  }

  String nextPdf(bool nextPage) {
    if (fileName == "") return "";
    List<String> temp = fileName.split('-');
    print(temp);
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
        return "${temp[0]}-${temp[1]}-${temp[2]}-${temp[3]}-${int.parse(temp[4].split('.')[0]) - 1}";
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
