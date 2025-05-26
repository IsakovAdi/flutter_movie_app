import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final bool adult;
  final String backdropImage;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterImage;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  const MovieEntity({
   required this.adult,
   required this.backdropImage,
   required this.genreIds,
   required this.id,
   required this.originalLanguage,
   required this.originalTitle,
   required this.overview,
   required this.popularity,
   required this.posterImage,
   required this.releaseDate,
   required this.title,
   required this.video,
   required this.voteAverage,
   required this.voteCount,
  });

  @override
  List<Object?> get props => [
    adult,
    backdropImage,
    genreIds,
    id,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterImage,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  ];
}
