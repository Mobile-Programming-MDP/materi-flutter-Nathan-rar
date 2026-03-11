import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'home_screens.dart';
import 'search_screen.dart';
import 'favorite_screen.dart';

/// The application's main landing page.  This widget manages a simple
/// navigation stack represented by [_screens] and tracks the current
/// selection with [_selectedIndex].
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Movie> _favoriteMovies = [];

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      SearchScreen(onToggleFavorite: _toggleFavorite, favoriteMovies: _favoriteMovies),
      FavoriteScreen(favoriteMovies: _favoriteMovies, onRemoveFavorite: _removeFavorite),
    ];
  }

  void _toggleFavorite(Movie movie) {
    setState(() {
      if (_favoriteMovies.contains(movie)) {
        _favoriteMovies.remove(movie);
      } else {
        _favoriteMovies.add(movie);
      }
    });
  }

  void _removeFavorite(Movie movie) {
    setState(() {
      _favoriteMovies.remove(movie);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
