// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rickandmorty/data/api/charactors_api.dart';

import '../models/character.dart';

class CharactersRepository {
  CharactersApi api;
  CharactersRepository({
    required this.api,
  });

  Future<List<Character>> getCharacters(int page) async {
    return api.getCharacters(page);
  }

  Future<int> getPages() async {
    return api.getPages();
  }

  Future<List<Character>> searchCharacters(String name) async {
    return api.searchCharacters(name);
  }
}
