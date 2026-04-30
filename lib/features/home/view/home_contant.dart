import 'package:flutter/material.dart';
import 'package:movies_app/features/widgets/featured_movie.dart';
import 'package:movies_app/features/widgets/movie_card.dart';
import 'package:movies_app/features/widgets/section_header.dart';
import 'package:movies_app/features/home/viewModel/movie_provider.dart';
import 'package:movies_app/core/themes/appTheme/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeContant extends StatefulWidget {
  const HomeContant({super.key});

  @override
  State<HomeContant> createState() => _HomeContantState();
}

class _HomeContantState extends State<HomeContant>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = [
    'Trending',
    'Popular',
    'Now Playing',
    'Top Rated',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        // ── AppBar ────────────────────────────────────────
        SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.movie_filter_rounded,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                size: 20,
              ),
            ),
          ),
          title: Text(
            'Vimo',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                context.watch<ThemeProvider>().isDark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () => context.read<ThemeProvider>().toggleTheme(),
            ),
          ],
        ),

        // ── Featured Movie ────────────────────────────────
        if (provider.nowPlayingMovies.isNotEmpty)
          SliverToBoxAdapter(
            child: FeaturedMovie(movie: provider.nowPlayingMovies.first),
          ),

        // ── Tab Bar ───────────────────────────────────────
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyTabBarDelegate(
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(
                context,
              ).textTheme.bodySmall?.color,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
            Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ],

      // ── Tab Bar View ──────────────────────────────────
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).primaryColor,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    provider.errorMessage!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.fetchAllMovies(),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                // ── Trending ──
                _MovieGrid(
                  movies: provider.topRatedMovies,
                  heroTag: 'trending',
                ),
                // ── Popular ──
                _MovieGrid(movies: provider.popularMovies, heroTag: 'popular'),
                // ── Now Playing ──
                _MovieGrid(
                  movies: provider.nowPlayingMovies,
                  heroTag: 'nowPlaying',
                ),
                // ── Top Rated ──
                _MovieGrid(
                  movies: provider.topRatedMovies,
                  heroTag: 'topRated',
                ),
              ],
            ),
    );
  }
}

// ============================================================
// Movie Grid Widget
// ============================================================
class _MovieGrid extends StatelessWidget {
  final List movies;
  final String heroTag;

  const _MovieGrid({required this.movies, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 9,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) => MovieCard(
        movie: movies[index],
        heroTag: heroTag,
        width: 160,
        height: 180,
      ),
    );
  }
}

// ============================================================
// Sticky Tab Bar Delegate
// ============================================================
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;

  const _StickyTabBarDelegate(this.tabBar, this.backgroundColor);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: backgroundColor, child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) => false;
}
