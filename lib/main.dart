import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/core/themes/appTheme/app_theme.dart';
import 'package:movies_app/features/splash/splash_screen.dart';
import 'package:movies_app/data/network/dio_client.dart';
import 'package:movies_app/features/details/viewModel/details_provider.dart';
import 'package:movies_app/features/myFavorite/viewModel/favourite_provider.dart';
import 'package:movies_app/features/search/viewModel/search_provider.dart';
import 'package:movies_app/core/themes/appTheme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/data/services/movie_repo.dart';
import 'package:movies_app/data/services/movie_service.dart';
import 'package:movies_app/features/home/viewModel/movie_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final dio = DioClient.getInstance();
  final service = MovieService(dio);
  final repository = MovieRepo(service);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider(repository)),
        ChangeNotifierProvider(create: (_) => SearchProvider(repository)),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider(repository)),
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
