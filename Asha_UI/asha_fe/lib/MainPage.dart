import 'package:flutter/material.dart';

import 'MainPage/widgets/result_tile.dart';
import 'utils/networking.dart';

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
    futureData = Networking.fetchData("");
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      // Set the height of the container or use Expanded
      height: height, // Replace 'height' with the actual height you want
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
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
                    height: height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Search');
                      setState(() {
                        futureData = Networking.fetchData(queryController.text);
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
                  return const Center(
                      child: Text('Please update link or report error'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  List<dynamic> temp = snapshot.data!["answers"];
                  String mainText, addnInfo, pageInfo;
                  return ListView.builder(
                    shrinkWrap: true, // Set shrinkWrap to true
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable scrolling
                    itemCount: temp.length,
                    itemBuilder: (context, index) {
                      mainText = temp[index]["answer"];
                      addnInfo = temp[index]["context"];
                      pageInfo = temp[index]["meta"]["name"].toString();
                      return ExpandableCard(
                        mainText: mainText,
                        additionalInfo: addnInfo,
                        pageName: pageInfo.length > 5
                            ? pageInfo.substring(0, pageInfo.length - 4)
                            : "Error",
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
