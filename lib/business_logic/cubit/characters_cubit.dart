import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/characters_repository.dart';

import '../../data/models/character.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  List<Character> characters = [];
  CharactersCubit({required this.repository}) : super(CharactersInitial());
  final CharactersRepository repository;

  int prevPage = 0;
  int nextPage = 0;

  void paging() {
    if (nextPage <= 42) {
      prevPage = nextPage;
      nextPage++;
    }
  }

  void fetchCharacters() async {
    paging();

    if (nextPage == 1) {
      emit(LoadingCharacters());
    }
    if (nextPage > 42) return;

    try {
      final characters = await repository.getCharacters(nextPage);
      this.characters.addAll(characters);
      emit(LoadedCharacters(characters: this.characters));
    } catch (error) {
      emit(ErrorCharacters(message: error.toString()));
    }
    log(characters.length.toString());
  }

  void searchCharacter(String query) async {
    emit(LoadingCharacters());
    try {
      if (query.isNotEmpty) {
        final searchedList = await repository.searchCharacters(query);
        emit(LoadedCharacters(characters: searchedList));
      } else {
        emit(LoadedCharacters(characters: characters));
      }
    } catch (error) {
      emit(const ErrorSearchCharacters(message: "Character Not Found "));
    }
  }
}
