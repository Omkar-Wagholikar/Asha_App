import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class HiveBoxes {
  static Box? box;
  static Box? bookmarks;

  static Future<void> updatePDFAssetValues() async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> assetManifest = json.decode(manifestJson);
    List<Map<String, dynamic>> pdfList = assetManifest.keys
        .where((String key) => key.startsWith('assets/pdfs'))
        .map((element) => {
              "fileName": element.split("/")[2],
              "filePath": element,
              "isAsset": true,
            })
        .toList();

    HiveBoxes.box?.addAll(pdfList);
  }
}
