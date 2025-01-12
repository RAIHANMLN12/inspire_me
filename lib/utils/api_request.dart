import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inspire_me/model/quote.dart';

class ApiService {

  Future<Quote> fetchRandomQuote() async {
    final url = Uri.parse("http://api.quotable.io/random");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Quote.fromJson(data);
      } else {
        throw Exception("Failed to load quote");
      }
    } catch (e) {
      rethrow;
    }
  }
}