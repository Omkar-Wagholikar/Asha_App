import 'package:asha_fe/Constants/hive-boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:asha_fe/Components/appbar.dart';
import 'package:asha_fe/Components/glass_morphic_container.dart';
import 'package:asha_fe/Constants/theme.dart';
import 'package:asha_fe/PdfPage/bloc/pdf_bloc.dart';

import '../data/pdf_model.dart';
import '../widgets/pdf_display.dart';
import '../widgets/pdf_downloader_placeholder.dart';

class PdfPage extends StatefulWidget {
  final String fileName;
  final String query;
  const PdfPage({super.key, required this.fileName, required this.query});
  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final PdfBloc pdfBloc = PdfBloc(pdfModel: PdfModel(fileName: ""));

  var stacklog = Logger(
    printer: PrettyPrinter(),
  );

  var log = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

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
        backgroundColor: AppColors.screenBgColor,
        body: Center(
          child: BlocBuilder<PdfBloc, PdfState>(builder: (context, state) {
            if (state is PdfInitial || state is PdfLoading) {
              return const ShowDownloadingPdf();
            } else if (state is PdfLoadingSuccess) {
              log.i("state is PdfLoadingSuccess");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: BlocProvider.value(
                        value: pdfBloc,
                        child: ShowPdf(
                            filePath: pdfBloc.pdfModel.filePath,
                            isAsset: pdfBloc.pdfModel.isAsset)),
                  ),
                  GlassmorphicContainer(
                    borderRadius: 0,
                    sigmaX: 10,
                    sigmaY: 10,
                    child: Row(
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
                        ]),
                  )
                ],
              );
            } else {
              return Text("In $state");
            }
          }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: FloatingActionButton(
            onPressed: () async {
              log.d("Book marking: ${pdfBloc.pdfModel.fileName}");
              await HiveBoxes.bookmarks?.put(pdfBloc.pdfModel.fileName, {
                "filePath": pdfBloc.pdfModel.filePath,
                "query": widget.query
              });
            },
            child: Icon(AppIcons.bookmarkedPages),
          ),
        ),
      ),
    );
  }
}
