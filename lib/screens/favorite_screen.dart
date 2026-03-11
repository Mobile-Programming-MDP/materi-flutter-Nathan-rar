import 'package:flutter/material.dart';
import '../models/movie.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key, required this.favoriteMovies, required this.onRemoveFavorite});

  final List<Movie> favoriteMovies;
  final void Function(Movie) onRemoveFavorite;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: widget.favoriteMovies.isEmpty
          ? const Center(
              child: Text('No favorite movies yet.'),
            )
          : ListView.builder(
              itemCount: widget.favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = widget.favoriteMovies[index];
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
                    onPressed: () => widget.onRemoveFavorite(movie),
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
    );
  }
}