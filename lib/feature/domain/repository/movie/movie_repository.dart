import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/feature/domain/entities/movie/movie_entity.dart';

abstract class MovieRepository {
  // Future<Either<Failure, MovieResponseEntity>> getPopularMovies(int page);

  Future<Either<Failure, List<MovieEntity>>> getNowPlayingMovies(int page);

  // Future<Either<Failure, MovieResponseEntity>> getUpcomingMovies(int page);
  //
  // Future<Either<Failure, MovieResponseEntity>> getTopRatedMovies(int page);

}
