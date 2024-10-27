import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/bloc/characters_bloc.dart';
import '../../business_logic/cubit/search_cubit.dart';
import '../../helper/contstants/my_colors.dart';
import '../../business_logic/cubit/characters_cubit.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is ChangeSearchState) {
          return state.isSearch
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: searchController,
                        cursorColor: MyColors.secondary,
                        decoration: const InputDecoration(
                          hintText: "Find your Character...",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 18, color: MyColors.secondary),
                        ),
                        style: const TextStyle(
                            fontSize: 18, color: MyColors.primary),
                        onChanged: (value) {
                          searchCharacters(context: context, name: value);
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        searchController.clear();
                        searchCharacters(context: context, name: "");
                        Navigator.pop(context);
//
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                )
              : searchController.text.isNotEmpty
                  ? Text(
                      "Characters in the search ${searchController.text}",
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : const Text("Characters");
        }
        return const Text("Characters");
      },
    );

    // return SearchBar(
    //   controller: searchController,
    //   onChanged: (value) {
    //     print('Searching for: ${searchController.text}');
    //   },
    //   leading: IconButton(
    //     onPressed: () {
    //       // Perform search action
    //       print('Searching for: ${searchController.text}');
    //     },
    //     icon: const Icon(Icons.search),
    //   ),
    //   trailing: [
    //     IconButton(
    //       onPressed: () {
    //         searchController.clear();
    //       },
    //       icon: const Icon(Icons.clear),
    //     ),
    //   ],
    // );
  }

  void searchCharacters({required String name, required BuildContext context}) {
    BlocProvider.of<CharactersBloc>(context)
        .add(SearchCharactersEvent(query: name));
  }
}
