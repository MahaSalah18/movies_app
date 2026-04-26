import 'package:dio/dio.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/data/services/movie_service.dart';

class MovieRepo {
  final MovieService service;
  MovieRepo(this.service);

  // helper صغير يتجنب التكرار
  List<Movie> _parseMovies(Response response) {
    return (response.data['results'] as List)
        .map((json) => Movie.fromJson(json))
        .toList();
  }

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await service.fetchPopularMovies();
    final results = response.data['results'] as List?;
    if (results == null) {
    throw Exception('Popular: null'); // ← ده اللي بيحصل دلوقتي
  }
    return _parseMovies(response);
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    final response = await service.fetchTopRatedMovies();
    return _parseMovies(response);
  }

  Future<List<Movie>> fetchNowPlayingMovies() async {
    final response = await service.fetchNowPlayingMovies();
    return _parseMovies(response);
  }
}