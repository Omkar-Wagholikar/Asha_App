import 'dart:async';
import 'dart:convert';
import 'package:asha_fe/PdfPage/data/pdf_model.dart';
import 'package:asha_fe/Utils/networking.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
part 'pdf_events.dart';
part 'pdf_states.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  PdfModel pdfModel;
  PdfBloc({required this.pdfModel}) : super(PdfInitial()) {
    on<InitialPdfEvent>(initialPdfEvent);
    on<PdfButtonPressedEvent>(pdfButtonPressedEvent);
    on<PdfNextButtonPressedEvent>(pdfNextButtonPressedEvent);
  }

  Future<List<String>> listAssets() async {
    List<String> assets = <String>[];

    try {
      String manifestContent =
          await rootBundle.loadString('AssetManifest.json');
      Map<String, dynamic> manifestMap = json.decode(manifestContent);

      assets = manifestMap.keys.toList();
    } catch (e) {
      print('Error listing assets: $e');
    }

    return assets;
  }

  FutureOr<void> initialPdfEvent(
      InitialPdfEvent event, Emitter<PdfState> emit) async {
    print("InitialPdfEvent");
    emit(PdfInitial());

    pdfModel = PdfModel(fileName: event.initialFileName);

    if (await pdfModel.isLocal()) {
      // local sync fusion rendering
      print("initialFileName is here");
    } else {
      // downloading
      print("initialFileName is not here");
      print("Downloading");
      await Networking.downloadPDF("book-no-2-page-12");
      print("Download complete");
    }

    emit(PdfLoadingSuccess(pdfModel: pdfModel));
  }

  FutureOr<void> pdfButtonPressedEvent(
      PdfButtonPressedEvent event, Emitter<PdfState> emit) async {
    emit(PdfLoading());

    pdfModel = PdfModel(fileName: event.fileName);
    if (await pdfModel.isLocal()) {
      // local sync fusion rendering
      print("This is here");
      emit(PdfLoadingSuccess(pdfModel: pdfModel));
    } else {
      // downloading
      // make changes to networking.dart to support this
      print("This is not here");
      emit(PdfLoadingSuccess(pdfModel: PdfModel(fileName: "book-no-1-page-1")));
    }
  }

  FutureOr<void> pdfNextButtonPressedEvent(
      PdfNextButtonPressedEvent event, Emitter<PdfState> emit) async {
    emit(PdfLoading());
    pdfModel = PdfModel(fileName: pdfModel.nextPdf(event.isNextPage));

    print("pdfNextButtonPressedEvent");
    print(pdfModel.fileName);
    if (await pdfModel.isLocal()) {
      // local sync fusion rendering
      print("Next button pressed event");
      emit(PdfLoadingSuccess(pdfModel: pdfModel));
    } else {
      // downloading
      // make changes to networking.dart to support this
      print("Next button pressed event");
      emit(PdfLoadingSuccess(pdfModel: PdfModel(fileName: "book-no-1-page-1")));
    }
  }
}
