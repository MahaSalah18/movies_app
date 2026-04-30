import 'package:flutter/material.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/features/widgets/genre_chip.dart';
import 'package:movies_app/features/widgets/rating_badge.dart';
import 'package:movies_app/features/details/viewModel/details_provider.dart';
import 'package:movies_app/features/myFavorite/viewModel/favourite_provider.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.movie});
  final Movie movie;
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<DetailsProvider>().fetchCast(widget.movie.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final favouriteProvider = context.watch<FavouriteProvider>();
    final provider = context.watch<DetailsProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  favouriteProvider.toggleFavourite(widget.movie);
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    favouriteProvider.isFavourite(widget.movie)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.movie.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: Icon(
                        Icons.movie,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        size: 60,
                      ),
                    ),
                  ),
                  // Gradient overlay
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Theme.of(context).scaffoldBackgroundColor,
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating + Year + Duration
                  Row(
                    children: [
                      RatingBadge(rating: widget.movie.rating, fontSize: 13),
                      const SizedBox(width: 10),
                      Text(
                        widget.movie.year.toString(),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: 13,
                        ),
                      ),
                      if (widget.movie.durationMinutes > 0) ...[
                        const SizedBox(width: 8),
                        Text(
                          '${widget.movie.durationMinutes} min',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Title
                  Text(
                    widget.movie.title,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Genre Chips
                  if (widget.movie.genres.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.movie.genres
                          .map((g) => GenreChip(label: g))
                          .toList(),
                    ),

                  const SizedBox(height: 20),

                  // Watch Now Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(
                        Icons.play_arrow,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      label: Text(
                        'Watch Now',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Synopsis
                  Text(
                    'Synopsis',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.movie.description,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Cast Section
                  Text(
                    'Cast',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (provider.isLoadingCast)
                    const CircularProgressIndicator()
                  else
                    SizedBox(
                      height: 120,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.cast.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final member = provider.cast[index];
                          return Column(
                            children: [
                              // صورة الممثل
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: member.profilePath.isNotEmpty
                                    ? NetworkImage(member.profilePath)
                                    : null,
                                child: member.profilePath.isEmpty
                                    ? Icon(
                                        Icons.person,
                                        color: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.color,
                                      )
                                    : null,
                              ),
                              const SizedBox(height: 6),
                              // اسم الممثل
                              Text(
                                member.name,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // اسم الشخصية
                              Text(
                                member.character,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.color,
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
