import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/exception.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/feature/data/datasource/remote/person/person_datasource.dart';
import 'package:movie_app/feature/data/mappers/person/person_mapper.dart';
import 'package:movie_app/feature/domain/entities/people/person.dart';
import 'package:movie_app/feature/domain/repository/person/person_repository.dart';

import '../../../../core/platform/network_info.dart';

class PersonRepositoryImpl implements PersonRepository {
  final NetworkInfo networkInfo;
  final PersonMapper mapper;
  final PersonDataSource dataSource;

  PersonRepositoryImpl({
    required this.networkInfo,
    required this.mapper,
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getPopularPersons(
    int page,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          (await dataSource.getPopularPersons(
            page,
          )).map((person) => mapper.mapFromDto(person)).toList(),
        );
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(
    String personName,
    int page,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          (await dataSource.searchPerson(
            personName,
            page,
          )).map((person) => mapper.mapFromDto(person)).toList(),
        );
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
