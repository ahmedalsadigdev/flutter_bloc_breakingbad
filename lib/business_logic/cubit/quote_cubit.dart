import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/quote.dart';
import '../../data/repository/quote_repository.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final QuoteRepository quoteRepository;
  QuoteCubit({required this.quoteRepository}) : super(QuoteInitial());

  void fetchQuote() async {
    emit(QuoteLoading());
    try {
      final quote = await quoteRepository.getQuote();
      emit(QuoteLoaded(quote: quote));
    } on Exception catch (error) {
      emit(QuoteError(message: error.toString()));
    }
  }
}
