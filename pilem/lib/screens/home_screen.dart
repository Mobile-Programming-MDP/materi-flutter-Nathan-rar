import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/screens/detail_screen.dart'; // <- correct name
import 'package:pilem/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  List<Movie> _allMovies = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];

  Future<void> _loadMovies() async {
    final all = await _apiService.getAllMovies();
    final trending = await _apiService.getTrendingMovies();
    final popular = await _apiService.getPopularMovies();

    setState(() {
      _allMovies = all;
      _trendingMovies = trending;
      _popularMovies = popular;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilem')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMoviesList('All Movies', _allMovies),
            _buildMoviesList('Trending Movies', _trendingMovies),
            _buildMoviesList('Popular Movies', _popularMovies),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesList(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        // thumbnails
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (BuildContext build, int index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(movie: movie),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        movie.title.length > 14
                            ? '${movie.title.substring(0, 10)}...'
                            : movie.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
