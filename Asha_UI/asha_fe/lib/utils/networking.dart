import 'dart:convert';
import 'dart:io';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:http/http.dart' as http;

class Networking {
  static String url = "http://202.52.53.125:4000";
  static Future<String> downloadPDF(String pdfName) async {
    try {
      File? file = await FileDownloader.downloadFile(
        url: "$url/api/pdf/$pdfName.pdf",
        name: "$pdfName.pdf",
        downloadDestination: DownloadDestinations.appFiles,
        onDownloadCompleted: (String path) {
          print('FILE DOWNLOADED TO PATH: $path');
        },
        onDownloadError: (String error) {
          print('DOWNLOAD ERROR: $error');
        },
      );
      print('FILE: ${file?.path}');
      return file?.path ?? "";
    } catch (e) {
      print("Error during PDF download: $e");
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> fetchData(String query) async {
    try {
      // final LocalStorage storage = LocalStorage('url.json');

      // print("Using the url: ${await storage.getItem('_url')}");

      final uri = Uri.parse('$url/answer/');

      Map<String, dynamic> body = {"query": query};
      var response = await http.post(
        uri,
        body: body,
      );

      var resp = json.decode(response.body);
      print("-> \n$resp \n <-");
      return resp;
    } catch (e) {
      print("Caught: \n$e");
      rethrow; // rethrow the error to be caught by the FutureBuilder
    }
  }

  static Future<Map<String, dynamic>> reportError(String reportedError) async {
    try {
      // final LocalStorage storage = LocalStorage('url.json');

      // print("Using the url: ${await storage.getItem('_url')}");

      final uri = Uri.parse('$url/reportError/');

      Map<String, dynamic> body = {"error": reportedError};
      var response = await http.post(
        uri,
        body: body,
      );

      var resp = json.decode(response.body);

      print("Error registered: \n-> \n$resp \n <-");
      return resp;
    } catch (e) {
      print("Caught: \n$e");
      rethrow; // rethrow the error to be caught by the FutureBuilder
    }
  }
}
