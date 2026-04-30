import 'package:flutter/material.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/features/details/view/details.dart';
import 'package:movies_app/features/widgets/rating_badge.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({
    super.key,
    required this.movie,
    required this.width,
    required this.height,
    required this.heroTag,
  });
  final Movie movie;
  final double width;
  final double height;
  final String heroTag;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Details(movie: widget.movie)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الفيلم مع التقييم
            Hero(
              tag: 'movie-${widget.movie.id}-${widget.heroTag}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.network(
                      widget.movie.imageUrl,
                      width: widget.width,
                      height: widget.height,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: widget.width,
                        height: widget.height,
                        color: Theme.of(context).colorScheme.surface,
                        child: Icon(
                          Icons.movie,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          size: 40,
                        ),
                      ),
                    ),
                    // Rating badge في الركن
                    Positioned(
                      top: 8,
                      right: 8,
                      child: RatingBadge(
                        rating: widget.movie.rating,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            // اسم الفيلم
            Text(
              widget.movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
