import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class Networking {
  static Future<Map<String, dynamic>> fetchData(String query) async {
    try {
      final LocalStorage storage = LocalStorage('url.json');

      print("Using the url: ${await storage.getItem('_url')}");

      final uri = Uri.parse(await storage.getItem('_url') + '/answer/');

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
      final LocalStorage storage = LocalStorage('url.json');

      print("Using the url: ${await storage.getItem('_url')}");

      final uri = Uri.parse(await storage.getItem('_url') + '/reportError/');

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
