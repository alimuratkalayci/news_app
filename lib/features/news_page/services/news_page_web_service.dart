import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_page_model.dart';

class NewsService {
  final String _apiKey = 'My-Api-Key';
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<News> fetchNewsData(String country, String category) async {
    final url = Uri.parse(
        "$_baseUrl?country=$country&category=$category&apiKey=$_apiKey");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return News.fromJson(jsonData);
      } else {
        throw Exception("Failed to load news data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("An error occurred while fetching data: $e");
    }
  }
}
