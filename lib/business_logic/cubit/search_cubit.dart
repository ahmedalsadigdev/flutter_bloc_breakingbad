import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  bool isSearch = false;

  SearchCubit() : super(SearchInitial());

  void toggleSearch() {
    isSearch = !isSearch;

    emit(ChangeSearchState(isSearch: isSearch));
  }
}
