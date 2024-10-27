part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

class ChangeSearchState extends SearchState {
  final bool isSearch;

  const ChangeSearchState({required this.isSearch});

  @override
  List<Object> get props => [isSearch];
}
