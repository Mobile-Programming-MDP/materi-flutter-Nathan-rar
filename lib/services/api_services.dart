import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = 'eb646ebbffea8198a2e4eddca93911c5';

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse(
      "$_baseUrl/search/movie?query=$query&api_key=$_apiKey",
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }
}
