class CastMember {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  CastMember({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      id: json['id'] as int,
      name: json['name'] as String,
      character: json['character'] as String? ?? '',
      profilePath: json['profile_path'] != null
          ? 'https://image.tmdb.org/t/p/w200${json['profile_path']}'
          : '', 
    );
  }
}