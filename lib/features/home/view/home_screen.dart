import 'package:flutter/material.dart';
import 'package:movies_app/features/home/view/home_contant.dart';
import 'package:movies_app/features/myFavorite/view/favorites_screen.dart';
import 'package:movies_app/features/search/view/search_screen.dart';
import 'package:movies_app/features/trending/trending_screen.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/features/widgets/cine_hub_nav_bar_button.dart';
import 'package:movies_app/features/home/viewModel/movie_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentNavIndex = 0;

  final List<Widget> _screens = [
    const HomeContant(), // index 0
    const SearchScreen(), // index 1
    const TrendingScreen(), // index 2
    const FavoritesScreen(), // index 3
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MovieProvider>().fetchAllMovies());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _screens.elementAt(_currentNavIndex),
      bottomNavigationBar: CineHubNavBarButton(
        currentIndex: _currentNavIndex,
        onTap: (index) => setState(() => _currentNavIndex = index),
      ),
    );
  }
}
