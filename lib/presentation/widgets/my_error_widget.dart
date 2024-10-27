import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/characters_cubit.dart';

class MyErrorWidget extends StatelessWidget {
  final String message;
  const MyErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(message),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<CharactersCubit>(context).fetchCharacters();
          },
          child: const Text("Try again"),
        )
      ],
    );
  }
}

class MyErrorSearchWidget extends StatelessWidget {
  final String message;
  const MyErrorSearchWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
