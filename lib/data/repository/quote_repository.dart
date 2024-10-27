// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../api/quote_api.dart';
import '../models/quote.dart';

class QuoteRepository {
  QuoteApi api;
  QuoteRepository({
    required this.api,
  });

  Future<Quote> getQuote() async {
    return api.getQuote();
  }
}
