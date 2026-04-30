import 'package:flutter/material.dart';
import '../../../data/models/movie.dart';
import '../../../data/services/movie_repo.dart';

class SearchProvider extends ChangeNotifier {
  final MovieRepo repository;
  SearchProvider(this.repository);

  List<Movie> searchResults = [];
  bool isLoading = false;
  String? errorMessage;
  bool hasSearched = false;

  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      searchResults = [];
      hasSearched = false;
      notifyListeners();
      return;
    }

    isLoading = true;
    hasSearched = true;
    errorMessage = null;
    notifyListeners();

    try {
      searchResults = await repository.fetchSearchResults(query);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    searchResults = [];
    hasSearched = false;
    errorMessage = null;
    notifyListeners();
  }
}
