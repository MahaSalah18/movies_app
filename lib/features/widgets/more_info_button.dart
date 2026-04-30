import 'package:flutter/material.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/features/details/view/details.dart';

class MoreInfoButton extends StatelessWidget {
  final Movie movie;
  const MoreInfoButton({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => Details(movie: movie)),
        );
      },
      icon: Icon(Icons.info_outline, size: 18),
      label: Text('More Info', style: TextStyle(fontWeight: FontWeight.bold)),
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        fixedSize: Size(130, 30),
        side: BorderSide(
          color:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ??
              Theme.of(context).dividerColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
