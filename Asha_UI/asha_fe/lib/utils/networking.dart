import 'dart:convert';
import 'dart:io';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Networking {
  static var stacklog = Logger(
    printer: PrettyPrinter(),
  );

  static var log = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  static String url = "http://202.52.53.125:4000";
  static Future<String> downloadPDFtoFilePath(String pdfName) async {
    try {
      File? file = await FileDownloader.downloadFile(
        url: "$url/api/pdf/$pdfName.pdf",
        name: "$pdfName.pdf",
        downloadDestination: DownloadDestinations.appFiles,
        onDownloadCompleted: (String path) {
          log.i('FILE DOWNLOADED TO PATH: $path');
        },
        onDownloadError: (String error) {
          log.i('DOWNLOAD ERROR: $error');
        },
      );
      log.i('FILE: ${file?.path}');
      return file?.path ?? "";
    } catch (e) {
      log.i("Error during PDF download: $e");
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> fetchData(String query) async {
    try {
      final uri = Uri.parse('$url/answer/');

      Map<String, dynamic> body = {"query": query};
      var response = await http.post(
        uri,
        body: body,
      );

      var resp = json.decode(response.body);
      log.t("-> \n$resp \n <-");
      return resp;
    } catch (e) {
      log.i("Caught: \n$e");
      rethrow; // rethrow the error to be caught by the FutureBuilder
    }
  }

  static Future<Map<String, dynamic>> reportError(String reportedError) async {
    try {
      final uri = Uri.parse('$url/reportError/');

      Map<String, dynamic> body = {"error": reportedError};
      var response = await http.post(
        uri,
        body: body,
      );

      var resp = json.decode(response.body);

      log.t("Error registered: \n-> \n$resp \n <-");
      return resp;
    } catch (e) {
      log.i("Caught: \n$e");
      rethrow; // rethrow the error to be caught by the FutureBuilder
    }
  }
}
