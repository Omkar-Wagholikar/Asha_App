import 'dart:async';
import 'package:asha_fe/PdfPage/data/pdf_model.dart';
// import 'package:asha_fe/utils/networking.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'pdf_events.dart';
part 'pdf_states.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  PdfModel pdfModel;
  PdfBloc({required this.pdfModel}) : super(PdfInitial()) {
    on<InitialPdfEvent>(initialPdfEvent);
    on<PdfButtonPressedEvent>(pdfButtonPressedEvent);
    on<PdfNextButtonPressedEvent>(pdfNextButtonPressedEvent);
  }

  FutureOr<void> initialPdfEvent(
      InitialPdfEvent event, Emitter<PdfState> emit) async {
    print("InitialPdfEvent");
    emit(PdfInitial());
    pdfModel = PdfModel(fileName: event.initialFileName);
    emit(PdfLoadingSuccess(pdfModel: pdfModel));
  }

  FutureOr<void> pdfButtonPressedEvent(
      PdfButtonPressedEvent event, Emitter<PdfState> emit) async {
    emit(PdfLoading());

    pdfModel = PdfModel(fileName: event.fileName);
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
    pdfModel = PdfModel(fileName: pdfModel.nextPdf(event.isNextPage));

    print("pdfNextButtonPressedEvent");
    print(pdfModel.fileName);
    if (await pdfModel.isLocal()) {
      // local sync fusion rendering
      emit(PdfLoadingSuccess(pdfModel: pdfModel));
    } else {
      // downloading
      // make changes to networking.dart to support this
      emit(PdfLoadingSuccess(pdfModel: PdfModel(fileName: "book-no-1-page-1")));
    }
  }
}
