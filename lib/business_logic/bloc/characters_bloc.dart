import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/character.dart';
import '../../data/repository/characters_repository.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository repository;
  List<Character> characters = [];
  int prevPage = 0;
  int nextPage = 0;
  int pages = 0;
  CharactersBloc({required this.repository}) : super(CharactersInitial()) {
    void paging() {
      if (nextPage <= pages) {
        prevPage = nextPage;
        nextPage++;
      }
    }

    on<CharactersEvent>((event, emit) async {
      if (event is FetchCharactersEvent) {
        paging();

        if (nextPage == 1) {
          emit(LoadingCharacters());
        }
        if (nextPage > pages) return;

        try {
          final newCharacters = await repository.getCharacters(nextPage);
          characters = List.of(characters..addAll(newCharacters));
          if (kDebugMode) {
            print("characters.length: ${characters.length}");
          }
          // final list = List.of(characters);
          emit(LoadedCharacters(characters: characters));
        } catch (error) {
          emit(ErrorCharacters(message: error.toString()));
        }
        log(characters.length.toString());
      } else if (event is GetCharactersPagesEvent) {
        pages = await repository.getPages();
        emit(GetCharactersPages(pagesNumber: pages));
      } else if (event is SearchCharactersEvent) {
        emit(LoadingCharacters());
        try {
          if (event.query.isNotEmpty) {
            final searchedList = await repository.searchCharacters(event.query);
            emit(LoadedCharacters(characters: searchedList));
          } else {
            emit(LoadedCharacters(characters: characters));
          }
        } catch (error) {
          emit(const ErrorSearchCharacters(message: "Character Not Found "));
        }
      }
    }, transformer: sequential());
  }
}
