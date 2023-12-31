import 'package:asha_fe/Components/appbar.dart';
import 'package:asha_fe/PdfPage/data/pdf_model.dart';
import 'package:asha_fe/PdfPage/pages/pdf_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../widgets/result_tile.dart';
import '../../Utils/web_exp.dart';
import '../bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBloc searchBloc = SearchBloc();
  TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    searchBloc.add(InitialSearchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => searchBloc,
      child: Scaffold(
        appBar: const AshaAppBar(
            appBarText: 'Asha App',
            appBarIconPath: "assets/images/PKC-logo.png"),
        body: Center(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return const CircularProgressIndicator();
              } else if (state is SearchLoadingSuccess) {
                // Handle the success state
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: queryController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Query',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print('Searching ${queryController.text}');
                              searchBloc.add(SearchButtonPressedEvent(
                                  query: queryController.text));
                            },
                            child: const Text('Search'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // PdfModel model =
                              //     PdfModel(fileName: "asha_ncd-page-2");
                              // print(
                              //     "The pfd isLocal status: ${await model.isLocal()}");
                              // print(model.nextPdf(true));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PdfPage(fileName: "book-no-1-page-11")));
                            },
                            child: const Text('pdf checker'),
                          ),
                          if (state.searchModel.answer.isNotEmpty)
                            BlocProvider.value(
                                value: searchBloc,
                                child: ListView.builder(
                                  shrinkWrap: true, // Set shrinkWrap to true
                                  physics:
                                      const NeverScrollableScrollPhysics(), // Disable scrolling
                                  itemCount: state
                                      .searchModel.answer['answers'].length,
                                  itemBuilder: (context, index) {
                                    String pageInfo = state
                                        .searchModel
                                        .answer['answers'][index]["meta"]
                                            ["name"]
                                        .toString();
                                    return ExpandableCard(
                                      mainText: state.searchModel
                                          .answer['answers'][index]["answer"],
                                      additionalInfo: state.searchModel
                                          .answer['answers'][index]["context"],
                                      pageName: pageInfo.length > 5
                                          ? pageInfo.substring(
                                              0, pageInfo.length - 4)
                                          : "Error",
                                    );
                                  },
                                ))
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                // Handle other states if needed
                return const Text("Unexpected state");
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.settings_input_antenna_rounded),
            onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebViewExample()),
                  )
                }),
      ),
    );
  }
}
