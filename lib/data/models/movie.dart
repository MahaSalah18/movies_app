class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final double rating;
  final int year;
  final int durationMinutes;
  final List<String> genres;
  final String description;
  final bool isFeatured;
  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.year,
    required this.durationMinutes,
    required this.genres,
    required this.description,
    this.isFeatured = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      imageUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path'] ?? ''}',
      rating: (json['vote_average'] as num).toDouble(),
      year: int.parse((json['release_date'] as String).split('-').first),
       durationMinutes: json['runtime'] as int? ?? 0,
      genres: (json['genre_ids'] as List).map((id) => id.toString()).toList(),
      description: json['overview'] as String,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }
}
