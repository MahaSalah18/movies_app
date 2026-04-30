import 'package:flutter/material.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/features/widgets/genre_chip.dart';
import 'package:movies_app/features/widgets/more_info_button.dart';
import 'package:movies_app/features/widgets/rating_badge.dart';
import 'package:movies_app/features/widgets/watch_now_button.dart';

class FeaturedMovie extends StatelessWidget {
  final Movie movie;
  const FeaturedMovie({required this.movie});

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
                color: Theme.of(context).colorScheme.surface,
                child: Center(
                  child: Icon(
                    Icons.movie,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    size: 60,
                  ),
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
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'FEATURED',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
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
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RatingBadge(rating: movie.rating, fontSize: 13),
                      const SizedBox(width: 10),
                      Text(
                        movie.year.toString(),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 10,
                        ),
                      ),
                      if (movie.durationMinutes > 0) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '•',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${movie.durationMinutes}m',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
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
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: WatchNowButton()),
                      const SizedBox(width: 10),
                      Expanded(child: MoreInfoButton(movie: movie)),
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
