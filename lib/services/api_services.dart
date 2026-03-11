import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart'; // <<– added

class ApiService {
  static const String baseUrl = "https://api.themoviedb.org/3";
  // ganti dengan APIKey masing-masing
  static const String apiKey = "} eb646ebbffea8198a2e4eddca93911c5";

  Future<List<Movie>> getAllMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return (data['results'] as List)
        .map((m) => Movie.fromJson(m as Map<String, dynamic>))
        .toList();
  }

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/trending/movie/week?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return (data['results'] as List)
        .map((m) => Movie.fromJson(m as Map<String, dynamic>))
        .toList();
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return (data['results'] as List)
        .map((m) => Movie.fromJson(m as Map<String, dynamic>))
        .toList();
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse("$baseUrl/search/movie?query=$query&api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return (data['results'] as List)
        .map((m) => Movie.fromJson(m as Map<String, dynamic>))
        .toList();
  }
}
