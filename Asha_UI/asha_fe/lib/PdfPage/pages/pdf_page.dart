import 'dart:io';

import 'package:asha_fe/Components/appbar.dart';
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
  final PdfBloc pdfBloc = PdfBloc(pdfModel: PdfModel(fileName: ""));
  @override
  void initState() {
    super.initState();
    pdfBloc.add(InitialPdfEvent(widget.fileName));
    pdfBloc.pdfModel = PdfModel(fileName: widget.fileName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => pdfBloc,
      child: Scaffold(
        appBar: const AshaAppBar(),
        body: Center(
          child: BlocBuilder<PdfBloc, PdfState>(builder: (context, state) {
            if (state is PdfInitial || state is PdfLoading) {
              return const CircularProgressIndicator();
            } else if (state is PdfLoadingSuccess) {
              print("state is PdfLoadingSuccess");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: BlocProvider.value(
                        value: pdfBloc,
                        child: pdfBloc.pdfModel.isAsset
                            ? SfPdfViewer.asset(pdfBloc.pdfModel.filePath)
                            : SfPdfViewer.file(
                                File(pdfBloc.pdfModel.filePath))),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () => {
                            pdfBloc.add(PdfNextButtonPressedEvent(
                                isNextPage: false,
                                fileName: pdfBloc.pdfModel.fileName)),
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        IconButton(
                          onPressed: () => {
                            pdfBloc.add(PdfNextButtonPressedEvent(
                                isNextPage: true,
                                fileName: pdfBloc.pdfModel.fileName)),
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        )
                      ])
                ],
              );
            } else {
              return Text("In $state");
            }
          }),
        ),
      ),
    );
  }
}
