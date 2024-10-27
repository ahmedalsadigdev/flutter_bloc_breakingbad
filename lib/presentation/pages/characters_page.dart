import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/my_error_widget.dart';
import '../widgets/search_widget.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../business_logic/bloc/characters_bloc.dart';
import '../widgets/characters_widgets.dart';
import '../widgets/loading_widget.dart';
import '../widgets/no_internet_widget.dart';
import '../widgets/search_button_widget.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchWidget(),
        centerTitle: true,
        actions: const [
          SearchButtonWidget(),
        ],
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);
          if (connected) {
            return buildCharactersUi();
          } else {
            return const NoInternetWidget();
          }
        },
        child: const LoadingWidget(),
      ),
    );
  }

  Widget buildCharactersUi() {
    return BlocConsumer<CharactersBloc, CharactersState>(
      listener: (BuildContext context, CharactersState state) {
        if (state is GetCharactersPages) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${state.pagesNumber} pages"),
          ));
        }
      },
      builder: (context, state) {
        if (state is LoadedCharacters) {
          return CharactersWidget(characters: state.characters);
        } else if (state is ErrorCharacters) {
          return MyErrorWidget(
            message: state.message,
          );
        } else if (state is ErrorSearchCharacters) {
          return MyErrorSearchWidget(
            message: state.message,
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
