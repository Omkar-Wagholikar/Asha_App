part of 'pdf_bloc.dart';

@immutable
sealed class PdfState {}

final class PdfInitial extends PdfState {}

final class PdfLoading extends PdfState {}

final class PdfLoadingSuccess extends PdfState {
  final PdfModel pdfModel;
  PdfLoadingSuccess({required this.pdfModel});
}

final class PdfNextButtonPressState extends PdfState {
  final PdfModel pdfModel;

  PdfNextButtonPressState({required this.pdfModel});
}
