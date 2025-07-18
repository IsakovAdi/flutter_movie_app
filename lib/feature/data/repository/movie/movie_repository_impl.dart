import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/exception.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/platform/network_info.dart';
import 'package:movie_app/feature/data/datasource/remote/movie/movie_data_source.dart';
import 'package:movie_app/feature/data/mappers/movie_mappers/movie_mapper.dart';
import 'package:movie_app/feature/domain/entities/movie/movie_entity.dart';
import 'package:movie_app/feature/domain/repository/movie/movie_repository.dart';

enum ResponseType { POPULAR, TOP_RATED, UPCOMING, NOW_PLAYING }

class MovieRepositoryImpl extends MovieRepository {
  final NetworkInfo networkInfo;
  final MovieDataSource dataSource;
  final MovieMapper mapper;

  MovieRepositoryImpl({
    required this.networkInfo,
    required this.dataSource,
    required this.mapper,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> getNowPlayingMovies(
    int page,
  ) async {
    return _makeResponse(page, ResponseType.NOW_PLAYING);
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(int page) async {
    return _makeResponse(page, ResponseType.POPULAR);
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getTopRatedMovies(int page) async {
    return _makeResponse(page, ResponseType.TOP_RATED);
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies(int page) async {
    return _makeResponse(page, ResponseType.UPCOMING);
  }

  Future<Either<Failure, List<MovieEntity>>> _makeResponse(
    int page,
    ResponseType type,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        switch (type) {
          case ResponseType.NOW_PLAYING:
            return Right(
              (await dataSource.getNowPlayingMovies(
                page,
              )).map((e) => mapper.mapFromDto(e)).toList(),
            );
          case ResponseType.TOP_RATED:
            return Right(
              (await dataSource.getTopRatedMovies(
                page,
              )).map((e) => mapper.mapFromDto(e)).toList(),
            );
          case ResponseType.UPCOMING:
            return Right(
              (await dataSource.getUpcomingMovies(
                page,
              )).map((e) => mapper.mapFromDto(e)).toList(),
            );

          case ResponseType.POPULAR:
            return Right(
              (await dataSource.getPopularMovies(
                page,
              )).map((e) => mapper.mapFromDto(e)).toList(),
            );
        }
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
