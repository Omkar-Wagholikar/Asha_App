part of 'searching_bloc.dart';

@immutable
sealed class SearchState {}

abstract class SearchActionState extends SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoadingSuccess extends SearchState {
  final SearchModel searchModel;

  SearchLoadingSuccess({required this.searchModel});
}
