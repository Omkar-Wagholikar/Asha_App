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
              child: const Text("sfpdfv_on_board"),
              onPressed: () {
                // String path = "assets/images/sample.pdf";
                String path = "assets/images/s1.pdf";
                if (path.isNotEmpty) {
                  PdfViewerController _pdfViewerController =
                      new PdfViewerController();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Scaffold(
                              appBar: AppBar(
                                title: const Text('PDF Viewer'),
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
            // ButtonToPDF(
            //     name: "name",
            //     render: SfPdfViewer.network(
            //         "http://localhost:7000/api/pdf/book-no-4-page-24.pdf/")),
            TextButton(
              child: const Text("sfpdfv_network"),
              onPressed: () {
                // String path = "assets/images/sample.pdf";
                String path = "assets/pdfs/book-no-1.pdf";
                if (path.isNotEmpty) {
                  PdfViewerController _pdfViewerController =
                      new PdfViewerController();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Scaffold(
                              appBar: AppBar(
                                title: const Text('PDF Viewer'),
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

class ButtonToPDF extends StatelessWidget {
  final Widget render;
  final String name;
  const ButtonToPDF({required this.name, required this.render, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(name),
      onPressed: () {
        String path = "assets/images/s1.pdf";
        if (path.isNotEmpty) {
          PdfViewerController pdfViewerController = PdfViewerController();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: const Text('PDF Viewer'),
                      ),
                      body: render,
                      floatingActionButton: FloatingActionButton(
                        onPressed: () => pdfViewerController.jumpToPage(13),
                      ),
                    )),
          );
        } else {
          print("====================== ate mud ====================");
        }
      },
    );
  }
}
