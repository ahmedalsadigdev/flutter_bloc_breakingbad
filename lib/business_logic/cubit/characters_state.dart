part of 'characters_cubit.dart';

sealed class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

final class CharactersInitial extends CharactersState {}

class LoadingCharacters extends CharactersState {}

class LoadedCharacters extends CharactersState {
  final List<Character> characters;

  const LoadedCharacters({required this.characters});

  @override
  List<Object> get props => [characters];
}

class ErrorCharacters extends CharactersState {
  final String message;
  const ErrorCharacters({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorSearchCharacters extends CharactersState {
  final String message;
  const ErrorSearchCharacters({required this.message});

  @override
  List<Object> get props => [message];
}
