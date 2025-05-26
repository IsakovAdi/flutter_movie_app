class MovieDto {
  final bool? adult;
  final String? backdropImage;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterImage;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  MovieDto({
    this.adult,
    this.backdropImage,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterImage,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
      adult: json["adult"],
      backdropImage: json["backdrop_path"],
      genreIds:
          (json["genre_ids"] as List<dynamic>).map((e) => e as int).toList(),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"],
      posterImage: json["poster_path"],
      releaseDate: json["release_date"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "adult": adult,
      "backdrop_path": backdropImage,
      "genre_ids": genreIds,
      "id": id,
      "original_language": originalLanguage,
      'original_title': originalTitle,
      "overview": overview,
      'popularity': popularity,
      'poster_path': posterImage,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
