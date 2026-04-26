import 'package:flutter/material.dart';
import 'package:movies_app/data/services/movie_repo.dart';
import '../data/models/movie.dart';


class MovieProvider extends ChangeNotifier {
  final MovieRepo repository;
  MovieProvider(this.repository);

  // ── State ──
  List<Movie> popularMovies    = [];
  List<Movie> topRatedMovies   = [];
  List<Movie> nowPlayingMovies = [];

  bool isLoading = false;
  String? errorMessage;

  // ── Fetch All ──
  Future<void> fetchAllMovies() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      popularMovies    = await repository.fetchPopularMovies();
      topRatedMovies   = await repository.fetchTopRatedMovies();
      nowPlayingMovies = await repository.fetchNowPlayingMovies();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}