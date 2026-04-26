
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/network/dio_client.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/data/services/movie_repo.dart';
import 'package:movies_app/data/services/movie_service.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/features/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print('API KEY: ${dotenv.env['API_KEY']}');
  print('BASE URL: ${dotenv.env['BASE_URL']}');
  final dio = DioClient.getInstance();
  final service = MovieService(dio);
  final repository = MovieRepo(service);

  runApp(
    MultiProvider(
      providers: [
        // ✅ بنمرر الـ repository للـ Provider
        ChangeNotifierProvider(create: (_) => MovieProvider(repository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
