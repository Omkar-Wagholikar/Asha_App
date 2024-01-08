part of 'searching_bloc.dart';

@immutable
sealed class SearchEvent {}

final class InitialSearchEvent extends SearchEvent {}

final class SearchButtonPressedEvent extends SearchEvent {
  final String query;
  SearchButtonPressedEvent({
    required this.query,
  });
}
