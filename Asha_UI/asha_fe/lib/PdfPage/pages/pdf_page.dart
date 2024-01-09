import 'package:asha_fe/Components/appbar.dart';
import 'package:asha_fe/Constants/theme.dart';
import 'package:asha_fe/PdfPage/bloc/pdf_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../data/pdf_model.dart';

class PdfPage extends StatefulWidget {
  final String fileName;
  const PdfPage({super.key, required this.fileName});
  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final PdfBloc pdfBloc = PdfBloc();
  late PdfModel pdfModel;
  @override
  void initState() {
    super.initState();
    pdfBloc.add(InitialPdfEvent(widget.fileName));
    pdfModel = PdfModel(fileName: widget.fileName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => pdfBloc,
      child: Scaffold(
        appBar: const AshaAppBar(
            appBarText: 'Asha App',
            appBarIconPath: "assets/images/PKC-logo.png"),
        body: Center(
          child: BlocBuilder<PdfBloc, PdfState>(builder: (context, state) {
            if (state is PdfInitial || state is PdfLoading) {
              return const CircularProgressIndicator();
            } else if (state is PdfLoadingSuccess) {
              print("state is PdfLoadingSuccess");
              print(pdfModel.nextPdf(true));
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: BlocProvider.value(
                        value: pdfBloc,
                        child: SfPdfViewer.asset(state.pdfModel.filePath)),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () => {
                            pdfModel =
                                PdfModel(fileName: pdfModel.nextPdf(false)),
                            pdfBloc.add(PdfButtonPressedEvent(
                                fileName: pdfModel.fileName)),
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        IconButton(
                          onPressed: () => {
                            pdfModel =
                                PdfModel(fileName: pdfModel.nextPdf(true)),
                            pdfBloc.add(PdfButtonPressedEvent(
                                fileName: pdfModel.fileName)),
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        )
                      ])
                ],
              );
            } else {
              return Container(
                child: Text("In $state"),
              );
            }
          }),
        ),
      ),
    );
  }
}
