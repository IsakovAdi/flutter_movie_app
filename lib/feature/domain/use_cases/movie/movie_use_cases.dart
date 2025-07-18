import 'package:dartz/dartz.dart';

import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/use_cases/use_cases.dart';
import 'package:movie_app/feature/domain/entities/movie/movie_entity.dart';
import 'package:movie_app/feature/domain/repository/movie/movie_repository.dart';

import '../params/params.dart';

class GetNowPlayingMoviesUseCase
    extends UseCase<List<MovieEntity>, PageParams> {
  final MovieRepository repository;

  GetNowPlayingMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(PageParams params) async {
    return await repository.getNowPlayingMovies(params.page);
  }
}

class GetPopularMoviesUseCase
    extends UseCase<List<MovieEntity>, PageParams> {
  final MovieRepository repository;

  GetPopularMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
    PageParams params,
  ) async {
    return await repository.getPopularMovies(params.page);
  }
}

class GetUpcomingMoviesUseCase
    extends UseCase<List<MovieEntity>, PageParams> {
  final MovieRepository repository;

  GetUpcomingMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
    PageParams params,
  ) async {
    return await repository.getUpcomingMovies(params.page);
  }
}

class GetTopRatedMoviesUseCase
    extends UseCase<List<MovieEntity>, PageParams> {
  final MovieRepository repository;

  GetTopRatedMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
    PageParams params,
  ) async {
    return await repository.getTopRatedMovies(params.page);
  }
}
