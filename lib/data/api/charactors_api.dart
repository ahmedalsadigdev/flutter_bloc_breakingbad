import 'dart:developer';

import 'package:dio/dio.dart';

import '../../helper/contstants/string.dart';
import '../models/character.dart';

class CharactersApi {
  late Dio dio;

  CharactersApi() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20));
    dio = Dio(options);
  }

  Future<List<Character>> getCharacters(int page) async {
    try {
      log(page.toString());
      Response response = await dio.get("character/?page=$page");

      final results = List.from(response.data["results"]);

      List<Character> characters =
          results.map((data) => Character.fromJson(data)).toList();
      return characters;
    } catch (error) {
      rethrow;
    }
  }

  Future<int> getPages() async {
    try {
      Response response = await dio.get("character");

      log(response.data["info"]["pages"].toString());

      int pages = response.data["info"]["pages"];

      return pages;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Character>> searchCharacters(String name) async {
    try {
      Response response = await dio.get("character/?name=$name");

      final results = List.from(response.data["results"]);

      List<Character> characters =
          results.map((data) => Character.fromJson(data)).toList();
      return characters;
    } catch (error) {
      rethrow;
    }
  }
}
