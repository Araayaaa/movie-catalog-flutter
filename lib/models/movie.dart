class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final List<Genre>? genres;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<Genre>? genres;
    if (json['genres'] != null) {
      genres = (json['genres'] as List).map((g) => Genre.fromJson(g)).toList();
    }

    return Movie(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      overview: json['overview'] ?? 'No overview available.',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'N/A',
      voteAverage: (json['vote_average'] ?? 0.0 as num).toDouble(),
      genres: genres,
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json['id'], name: json['name']);
  }
}
