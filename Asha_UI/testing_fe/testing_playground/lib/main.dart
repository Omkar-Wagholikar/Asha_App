import 'package:flutter/material.dart';

import 'package:testing_playground/pdfViewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    PdfViewerController _pdfViewerController = new PdfViewerController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/test.png"),
            TextButton(
              child: const Text("syncfusion_flutter_pdfviewer"),
              onPressed: () {
                // String path = "assets/images/sample.pdf";
                String path = "assets/images/s2.pdf";
                if (path.isNotEmpty) {
                  PdfViewerController _pdfViewerController =
                      new PdfViewerController();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Scaffold(
                              appBar: AppBar(
                                title:
                                    const Text('Syncfusion Flutter PDF Viewer'),
                              ),
                              body: SfPdfViewer.asset(
                                path,
                                controller: _pdfViewerController,
                              ),
                              floatingActionButton: FloatingActionButton(
                                onPressed: () =>
                                    _pdfViewerController.jumpToPage(13),
                              ),
                            )),
                  );
                } else {
                  print("====================== ate mud ====================");
                }
              },
            ),
            TextButton(
              child: const Text("Open Landscape PDF"),
              onPressed: () {
                String landscapePathPdf = "assets/images/sample.pdf";
                if (landscapePathPdf.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFScreen(path: landscapePathPdf),
                    ),
                  );
                } else {
                  print("====================== ate mud ====================");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
