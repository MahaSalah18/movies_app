import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/core/themes/colors/app_colors.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/features/widgets/cine_hub_nav_bar_button.dart';
import 'package:movies_app/features/widgets/genre_chip.dart';
import 'package:movies_app/features/widgets/more_info_button.dart';
import 'package:movies_app/features/widgets/movie_card.dart';
import 'package:movies_app/features/widgets/rating_badge.dart';
import 'package:movies_app/features/widgets/section_header.dart';
import 'package:movies_app/features/widgets/watch_now_button.dart';
import 'package:movies_app/providers/movie_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MovieProvider>().fetchAllMovies());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // ── AppBar ──────────────────────────────────────────
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.movie_filter_rounded,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
              ),
            ),
            title: const Text(
              'CineHub',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.dark_mode, color: AppColors.textPrimary),
                onPressed: () {},
              ),
            ],
          ),

          // ── Loading ──────────────────────────────────────────
          if (provider.isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          // ── Error ────────────────────────────────────────────
          else if (provider.errorMessage != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => provider.fetchAllMovies(),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            )
          // ── Data ─────────────────────────────────────────────
          else ...[
            // ── Featured Movie ───────────────────────────────
            if (provider.nowPlayingMovies.isNotEmpty)
              SliverToBoxAdapter(
                child: _FeaturedMovieSection(
                  movie: provider.nowPlayingMovies.first,
                ),
              ),

            // ── Trending Now — Grid 3 columns ────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: SectionHeader(title: 'Trending Now'),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => MovieCard(
                    movie: provider.topRatedMovies[index],
                    width: double.infinity,
                    height: 130,
                  ),
                  childCount: provider.topRatedMovies.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.65,
                ),
              ),
            ),

            // ── Popular — Horizontal List ────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: SectionHeader(title: 'Popular'),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: provider.popularMovies.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => MovieCard(
                    movie: provider.popularMovies[index],
                    width: 130,
                    height: 200,
                  ),
                ),
              ),
            ),

            // ── Now Playing — Horizontal List ────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: SectionHeader(title: 'Now Playing'),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: provider.nowPlayingMovies.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => MovieCard(
                    movie: provider.nowPlayingMovies[index],
                    width: double.infinity,
                    height: 130,
                  ),
                ),
              ),
            ),

            // ── Top Rated — Horizontal List ──────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: SectionHeader(title: 'Top Rated'),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: provider.topRatedMovies.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => MovieCard(
                    movie: provider.topRatedMovies[index],
                    width: 130,
                    height: 160,
                  ),
                ),
              ),
            ),

            //  SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ],
      ),
      bottomNavigationBar: CineHubNavBarButton(
        currentIndex: _currentNavIndex,
        onTap: (index) => setState(() => _currentNavIndex = index),
      ),
    );
  }
}

// ============================================================
// Featured Movie Section Widget
// ============================================================
class _FeaturedMovieSection extends StatelessWidget {
  final Movie movie;
  const _FeaturedMovieSection({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            // ── صورة الخلفية ──────────────────────────────
            Image.network(
              movie.imageUrl,
              height: 420,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 420,
                color: const Color(0xFF1A1A1A),
                child: const Center(
                  child: Icon(Icons.movie, color: Colors.white24, size: 60),
                ),
              ),
            ),

            // ── Gradient overlay ──────────────────────────
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.85),
                    ],
                    stops: const [0.2, 1.0],
                  ),
                ),
              ),
            ),

            // ── FEATURED badge ────────────────────────────
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'FEATURED',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),

            // ── Content فوق الصورة ────────────────────────
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RatingBadge(rating: movie.rating, fontSize: 13),
                      const SizedBox(width: 10),
                      Text(
                        movie.year.toString(),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 10,
                        ),
                      ),
                      if (movie.durationMinutes > 0) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '•',
                            style: TextStyle(color: AppColors.iconColor),
                          ),
                        ),
                        const Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: AppColors.white70,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${movie.durationMinutes}m',
                          style: const TextStyle(
                            color: AppColors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (movie.genres.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: movie.genres
                          .map((g) => GenreChip(label: g))
                          .toList(),
                    ),
                  const SizedBox(height: 10),
                  Text(
                    movie.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      WatchNowButton(),
                      const SizedBox(width: 10),
                      MoreInfoButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
