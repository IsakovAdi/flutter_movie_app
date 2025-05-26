import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/domain/entities/people/person.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props => [];
}

class PersonsEmpty extends PersonState{
  @override
  List<Object> get props => [];
}

class PersonsLoading extends PersonState {
  final List<PersonEntity> oldPersonsList;
  final bool isFirstFetch;

  const PersonsLoading(this.oldPersonsList, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldPersonsList];
}

class PersonsLoaded extends PersonState {
  final List<PersonEntity> personsList;

  const PersonsLoaded(this.personsList);
}

class PersonError extends PersonState {
  final String errorMessage;

  const PersonError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
