import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/domain/entities/people/person.dart';

class PersonsResponseEntity extends Equatable {
  final int page;
  final List<PersonEntity> persons;
  final int totalPages;
  final int totalResults;

  const PersonsResponseEntity({
    required this.page,
    required this.persons,
    required this.totalPages,
    required this.totalResults,
  });

  @override
  List<Object> get props => [page, persons, totalPages, totalResults];
}
