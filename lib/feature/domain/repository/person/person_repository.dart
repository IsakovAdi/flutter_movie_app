import 'package:dartz/dartz.dart';
import 'package:movie_app/feature/domain/entities/people/person.dart';

import '../../../../core/error/failure.dart';
abstract class PersonRepository{
  Future<Either<Failure, List<PersonEntity>>> getPopularPersons(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String personName, int page);

}