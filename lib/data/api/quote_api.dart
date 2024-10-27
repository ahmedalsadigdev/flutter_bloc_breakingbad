import 'package:dio/dio.dart';

import '../../helper/contstants/string.dart';
import '../models/quote.dart';

class QuoteApi {
  late Dio dio;

  QuoteApi() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrlQuote,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20));
    dio = Dio(options);
  }

  Future<Quote> getQuote() async {
    try {
      Response response = await dio.get("random");

      final results = response.data;

      final Quote quote = Quote.fromJson(results);
      return quote;
    } catch (error) {
      rethrow;
    }
  }
}
