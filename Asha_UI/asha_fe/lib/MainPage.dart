import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'temp.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController queryController = TextEditingController();
  late Future<Map<String, dynamic>> futureData;

  @override
  void initState() {
    super.initState();
    // Initialize the futureData in the initState
    futureData = fetchData();
  }

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final uri = Uri.parse('http://127.0.0.1:7000/answer/');

      Map<String, dynamic> body = {"query": queryController.text};
      var response = await http.post(
        uri,
        body: body,
      );

      var resp = json.decode(response.body);
      print("->");
      print(resp);
      print("<-");
      return resp;
    } catch (e) {
      print("Caught");
      print(e);
      throw e; // rethrow the error to be caught by the FutureBuilder
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        // Set the height of the container or use Expanded
        height: height, // Replace 'height' with the actual height you want
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: queryController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Query',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Search');
                      setState(() {
                        futureData = fetchData();
                      });
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: futureData, // Use the futureData here
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  List<dynamic> temp = snapshot.data!["answers"];
                  List<String> fin1 = [];

                  temp.forEach((element) {
                    fin1.add(element["answer"]);
                  });

                  return ListView.builder(
                    shrinkWrap: true, // Set shrinkWrap to true
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable scrolling
                    itemCount: temp.length,
                    itemBuilder: (context, index) {
                      return ExpandableCard(
                        mainText: fin1[index],
                        additionalInfo: temp[index]["context"],
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
