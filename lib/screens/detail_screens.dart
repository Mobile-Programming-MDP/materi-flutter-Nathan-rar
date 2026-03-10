import 'package:flutter/material.dart';

/// Placeholder detail screen; will later display movie information and
/// allow toggling favorite status.
class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIsFavorite();
  }

  void _checkIsFavorite() {
    // TODO: load favorite status from persistence or service
    setState(() {
      _isFavorite = false;
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      // TODO: persist new status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Image.network(
                  'https://via.placeholder.com/300x200',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Favorite: $_isFavorite'),
          ],
        ),
      ),
    );
  }
}
