import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/search_cubit.dart';

class SearchButtonWidget extends StatelessWidget {
  const SearchButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return state is ChangeSearchState
            ? state.isSearch
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      ModalRoute.of(context)!
                          .addLocalHistoryEntry(LocalHistoryEntry(
                        onRemove: () {
                          BlocProvider.of<SearchCubit>(context).toggleSearch();
                        },
                      ));
                      BlocProvider.of<SearchCubit>(context).toggleSearch();
                    },
                    icon: const Icon(Icons.search),
                  )
            : IconButton(
                onPressed: () {
                  ModalRoute.of(context)!
                      .addLocalHistoryEntry(LocalHistoryEntry(
                    onRemove: () {
                      BlocProvider.of<SearchCubit>(context).toggleSearch();
                    },
                  ));
                  BlocProvider.of<SearchCubit>(context).toggleSearch();
                },
                icon: const Icon(Icons.search),
              );
      },
    );
  }
}
