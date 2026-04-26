

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/core/constants/api_constants.dart';


class MovieService {
  final Dio dio;
  MovieService(this.dio);

 Future<Response> fetchPopularMovies() async {
  try {
    final response = await dio.get(ApiConstants.popular);
    log('Popular Response: ${response.data}'); // <-- دي هتطبع الرد في الـ console
 // ← دي هتساعدك تشوف الرد اللي جاي من السيرفر
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
}