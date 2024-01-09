import 'dart:async';
import 'package:asha_fe/PdfPage/data/pdf_model.dart';
// import 'package:asha_fe/utils/networking.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'pdf_events.dart';
part 'pdf_states.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  PdfBloc() : super(PdfInitial()) {
    on<InitialPdfEvent>(initialPdfEvent);
    on<PdfButtonPressedEvent>(pdfButtonPressedEvent);
    on<PdfNextButtonPressedEvent>(pdfNextButtonPressedEvent);
  }

  FutureOr<void> initialPdfEvent(
      InitialPdfEvent event, Emitter<PdfState> emit) async {
    print("InitialPdfEvent");
    emit(PdfInitial());
    emit(await PdfLoadingSuccess(
        pdfModel: PdfModel(fileName: event.initialFileName)));
  }

  FutureOr<void> pdfButtonPressedEvent(
      PdfButtonPressedEvent event, Emitter<PdfState> emit) async {
    emit(PdfLoading());

    PdfModel pdfModel = PdfModel(fileName: event.fileName);
    if (await pdfModel.isLocal()) {
      // local sync fusion rendering
      emit(PdfLoadingSuccess(pdfModel: pdfModel));
    } else {
      // downloading
      // make changes to networking.dart to support this
      emit(PdfLoadingSuccess(pdfModel: PdfModel(fileName: "book-no-1-page-1")));
    }
  }

  FutureOr<void> pdfNextButtonPressedEvent(
      PdfNextButtonPressedEvent event, Emitter<PdfState> emit) async {
    emit(PdfLoading());

    PdfModel currPdfModel = PdfModel(fileName: event.fileName);
    String nextPdfpath = currPdfModel.nextPdf(event.isNextPage);
    PdfModel nextPdfModel = PdfModel(fileName: nextPdfpath);

    if (await nextPdfModel.isLocal()) {
      // local sync fusion rendering
      emit(PdfLoadingSuccess(pdfModel: nextPdfModel));
    } else {
      // downloading
      // make changes to networking.dart to support this
      emit(PdfLoadingSuccess(pdfModel: PdfModel(fileName: "book-no-1-page-1")));
    }
  }
}
