import 'package:flutter/material.dart';

import 'package:movies_app/features/widgets/movie_card.dart';
import 'package:movies_app/features/myFavorite/viewModel/favourite_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavouriteProvider.of(context);
    final movieFavorites = provider.favourites;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            textAlign: TextAlign.center,
            'My Favorites',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => provider.clearAll(),
            icon: Icon(
              Icons.delete_outline_rounded,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: movieFavorites.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (_, index) => MovieCard(
                  movie: movieFavorites[index],
                  width: 140,
                  height: 160,
                  heroTag: 'favorite',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
