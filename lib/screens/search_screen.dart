import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.onToggleFavorite, required this.favoriteMovies});

  final void Function(Movie) onToggleFavorite;
  final List<Movie> favoriteMovies;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResults = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchMovies() async {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      try {
        final results = await _apiService.searchMovies(query);
        setState(() {
          _searchResults = results;
        });
      } catch (e) {
        print('Error searching movies: $e');
        // Show snackbar or dialog with error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _toggleFavorite(Movie movie) {
    widget.onToggleFavorite(movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search movies...',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              IconButton(
                onPressed: _searchMovies,
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final movie = _searchResults[index];
                return ListTile(
                  leading: movie.posterPath.isNotEmpty
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
                        )
                      : const Icon(Icons.image_not_supported),
                  title: Text(movie.title),
                  subtitle: Text(
                    movie.overview.length > 100
                        ? '${movie.overview.substring(0, 100)}...'
                        : movie.overview,
                  ),
                  trailing: IconButton(
                    onPressed: () => _toggleFavorite(movie),
                    icon: Icon(
                      widget.favoriteMovies.contains(movie) ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                  onTap: () {
                    // Navigate to detail screen
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
