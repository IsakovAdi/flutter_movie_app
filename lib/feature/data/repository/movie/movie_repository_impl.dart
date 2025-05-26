import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/exception.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/platform/network_info.dart';
import 'package:movie_app/feature/data/datasource/remote/movie/movie_data_source.dart';
import 'package:movie_app/feature/data/mappers/movie_mappers/movie_mapper.dart';
import 'package:movie_app/feature/domain/entities/movie/movie_entity.dart';
import 'package:movie_app/feature/domain/repository/movie/movie_repository.dart';

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
    if (await networkInfo.isConnected) {
      try {
        return Right(
          (await dataSource.getNowPlayingMovies(
            page,
          )).map((e) => mapper.mapFromDto(e)).toList(),
        );
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  // @override
  // Future<Either<Failure, MovieResponseEntity>> getPopularMovies(int page) {
  //   // TODO: implement getPopularMovies
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<Either<Failure, MovieResponseEntity>> getTopRatedMovies(int page) {
  //   // TODO: implement getTopRatedMovies
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<Either<Failure, MovieResponseEntity>> getUpcomingMovies(int page) {
  //   // TODO: implement getUpcomingMovies
  //   throw UnimplementedError();
  // }
}
