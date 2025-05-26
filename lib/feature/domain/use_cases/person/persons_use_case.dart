import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/use_cases/use_cases.dart';
import 'package:movie_app/feature/domain/entities/people/person.dart';
import 'package:movie_app/feature/domain/repository/person/person_repository.dart';

import '../params/params.dart';

class GetPopularPersonsUseCase extends UseCase<List<PersonEntity>, PageParams> {
  final PersonRepository repository;

  GetPopularPersonsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(PageParams params) async {
    return await repository.getPopularPersons(params.page);
  }
}

class SearchPersonUseCase
    extends UseCase<List<PersonEntity>, QueryAndPageParams> {
  final PersonRepository repository;

  SearchPersonUseCase(this.repository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
    QueryAndPageParams params,
  ) async {
    return await repository.searchPerson(params.query, params.page);
  }
}
