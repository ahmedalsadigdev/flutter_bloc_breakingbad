part of 'characters_bloc.dart';

sealed class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object> get props => [];
}

class FetchCharactersEvent extends CharactersEvent {}

class GetCharactersPagesEvent extends CharactersEvent {}

class SearchCharactersEvent extends CharactersEvent {
  final String query;
  const SearchCharactersEvent({required this.query});

  @override
  List<Object> get props => [query];
}
