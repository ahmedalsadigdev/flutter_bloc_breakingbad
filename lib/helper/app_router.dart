import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/bloc/characters_bloc.dart';
import '../business_logic/cubit/characters_cubit.dart';
import '../business_logic/cubit/quote_cubit.dart';
import '../business_logic/cubit/search_cubit.dart';
import '../data/api/charactors_api.dart';
import '../data/api/quote_api.dart';
import '../data/models/character.dart';
import '../data/repository/characters_repository.dart';
import '../data/repository/quote_repository.dart';
import 'contstants/string.dart';

import '../presentation/pages/characters_details_page.dart';
import '../presentation/pages/characters_page.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late QuoteRepository quoteRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(api: CharactersApi());
    charactersCubit = CharactersCubit(repository: charactersRepository);
    quoteRepository = QuoteRepository(api: QuoteApi());
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersPage:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    // BlocProvider(
                    //   create: (context) => charactersCubit..fetchCharacters(),
                    // ),
                    BlocProvider(
                      create: (context) =>
                          CharactersBloc(repository: charactersRepository)
                            ..add(GetCharactersPagesEvent())
                            ..add(FetchCharactersEvent()),
                    ),
                    BlocProvider(
                      create: (context) => SearchCubit(),
                    ),
                  ],
                  child: const CharactersPage(),
                ));
      case charactersDetailsPage:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      QuoteCubit(quoteRepository: quoteRepository),
                  child: CharactersDetailsPage(
                    character: character,
                  ),
                ));
    }
    return null;
  }
}
