import 'package:movie_app/feature/data/models/movie/movie_dto.dart';
import 'package:movie_app/feature/domain/entities/movie/movie_entity.dart';

class MovieMapper {
  MovieEntity mapFromDto(MovieDto from) {
    return MovieEntity(
      adult: from.adult ?? false,
      backdropImage: from.backdropImage ?? "",
      genreIds: from.genreIds ?? [],
      id: from.id ?? 0,
      originalLanguage: from.originalLanguage ?? "",
      originalTitle: from.originalTitle ?? "",
      overview: from.overview ?? "",
      popularity: from.popularity ?? 0,
      posterImage: from.posterImage ?? "",
      releaseDate: from.releaseDate ?? "",
      title: from.title ?? "",
      video: from.video ?? false,
      voteAverage: from.voteAverage ?? 0,
      voteCount: from.voteCount ?? 0,
    );
  }

  MovieDto mapToDto(MovieEntity from) {
    return MovieDto(
      adult: from.adult,
      backdropImage: from.backdropImage,
      genreIds: from.genreIds,
      id: from.id,
      originalLanguage: from.originalLanguage,
      originalTitle: from.originalTitle,
      overview: from.overview,
      popularity: from.popularity,
      posterImage: from.posterImage,
      releaseDate: from.releaseDate,
      title: from.title,
      video: from.video,
      voteAverage: from.voteAverage,
      voteCount: from.voteCount,
    );
  }
}
