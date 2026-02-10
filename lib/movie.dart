class Movie {
  int id;
  String title;
  double voteAverage;
  String releaseDate;
  String overview;
  String? posterPath;

  Movie(
    this.id,
    this.title,
    this.voteAverage,
    this.releaseDate,
    this.overview,
    this.posterPath,
  );

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      json['id'],
      json['title'],
      (json['vote_average'] as num).toDouble(),
      json['release_date'] ?? "",
      json['overview'] ?? "",
      json['poster_path'],
    );
  }
}
