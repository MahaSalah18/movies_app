import 'package:dio/dio.dart';
import 'package:movies_app/core/constants/api_constants.dart';

class MovieService {
  final Dio dio;
  MovieService(this.dio);

  Future<Response> fetchPopularMovies() async {
    try {
      final response = await dio.get(ApiConstants.popular);
      return response;
    } on DioException catch (e) {
      throw Exception('Popular: ${e.message}');
    }
  }

  Future<Response> fetchTopRatedMovies() async {
    try {
      return await dio.get(ApiConstants.topRated);
    } on DioException catch (e) {
      throw Exception('TopRated: ${e.message}');
    }
  }

  Future<Response> fetchNowPlayingMovies() async {
    try {
      return await dio.get(ApiConstants.nowPlaying);
    } on DioException catch (e) {
      throw Exception('NowPlaying: ${e.message}');
    }
  }

  Future<Response> searchMovies(String query) async {
    try {
      return await dio.get(
        ApiConstants.search,
        queryParameters: {'query': query},
      );
    } on DioException catch (e) {
      throw Exception('Search: ${e.message}');
    }
  }

  Future<Response> fetchMovieCredits(int movieId) async {
    try {
      return await dio.get('/movie/$movieId/credits');
    } on DioException catch (e) {
      throw Exception('Credits: ${e.message}');
    }
  }
}
