import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  static Dio getInstance() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL']!,
        queryParameters: {
          'api_key': dotenv.env['API_KEY'],
          'language': 'en-US',
          'page': 1,
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(responseBody: true), // ✅ هيطبع كل response
    );

    return dio;
  }
}