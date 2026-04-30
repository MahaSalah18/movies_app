import 'package:flutter/material.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:provider/provider.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<Movie> _favourites = [];
  List<Movie> get favourites => _favourites;

  void toggleFavourite(Movie movie) {
    if (_favourites.contains(movie)) {
      _favourites.remove(movie);
    } else {
      _favourites.add(movie);
    }
    notifyListeners();
  }

  bool isFavourite(Movie movie) {
    final isFavourite = _favourites.contains(movie);
    return isFavourite;
  }

  static FavouriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavouriteProvider>(context, listen: listen);
  }

  void clearAll() {
  _favourites.clear();
  notifyListeners();
}
}
