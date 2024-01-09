part of "pdf_bloc.dart";

@immutable
sealed class PdfEvent {}

final class InitialPdfEvent extends PdfEvent {
  final String initialFileName;

  InitialPdfEvent(this.initialFileName);
}

final class PdfButtonPressedEvent extends PdfEvent {
  final String fileName;
  PdfButtonPressedEvent({
    required this.fileName,
  });
}

final class PdfLoadedEvent extends PdfEvent {}

final class PdfNextButtonPressedEvent extends PdfEvent {
  final bool isNextPage;
  final String fileName;
  PdfNextButtonPressedEvent({
    required this.isNextPage,
    required this.fileName,
  });
}
