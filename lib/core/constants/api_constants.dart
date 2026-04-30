import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String baseUrl = dotenv.env['BASE_URL']!;
  static  String apiKey  = dotenv.env['API_KEY']!;
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // Paths فقط — مش URLs كاملة
  static const String popular    = '/movie/popular';
  static const String topRated   = '/movie/top_rated';
  static const String nowPlaying = '/movie/now_playing';
  static const String search     = '/search/movie';

}