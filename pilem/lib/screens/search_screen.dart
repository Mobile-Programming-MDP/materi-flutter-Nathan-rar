import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/screens/detail_screen.dart';
import 'package:pilem/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final _apiService = ApiService();
  final _searchController = TextEditingController();
  List<Movie> _movies = [];

  Future<void> _search() async {
    if (_searchController.text.isEmpty) return;
    final results = await _apiService.searchMovies(_searchController.text);
    setState(() {
      _movies = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: (_) => _search(),
              decoration: InputDecoration(
                hintText: 'Search movies',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          return ListTile(
            title: Text(movie.title),
            subtitle: Text(movie.releaseDate),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(movie: movie),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
