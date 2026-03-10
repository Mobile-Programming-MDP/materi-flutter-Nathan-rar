import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = 'eb646ebbffea8198a2e4eddca93911c5'; // Replace with your TMDB API key

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse(
      "$_baseUrl/search/movie?query=$query&api_key=$_apiKey",
    ));
    final data = json.decode(response.body);
    return (data['results'] as List).map((json) => Movie.fromJson(json)).toList();
  }

  Future<List<Movie>> getAllMovies() async {
    final response = await http.get(Uri.parse(
      "$_baseUrl/discover/movie?api_key=$_apiKey",
    ));
    final data = json.decode(response.body);
    return (data['results'] as List).map((json) => Movie.fromJson(json)).toList();
  }

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(
      "$_baseUrl/trending/movie/week?api_key=$_apiKey",
    ));
    final data = json.decode(response.body);
    return (data['results'] as List).map((json) => Movie.fromJson(json)).toList();
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(
      "$_baseUrl/movie/popular?api_key=$_apiKey",
    ));
    final data = json.decode(response.body);
    return (data['results'] as List).map((json) => Movie.fromJson(json)).toList();
  }
}
