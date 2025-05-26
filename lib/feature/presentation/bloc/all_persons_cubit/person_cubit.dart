import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/domain/entities/people/person.dart';
import 'package:movie_app/feature/domain/use_cases/params/params.dart';
import 'package:movie_app/feature/domain/use_cases/person/persons_use_case.dart';
import 'package:movie_app/feature/presentation/bloc/all_persons_cubit/person_state.dart';
import 'package:movie_app/feature/presentation/bloc/error_handler.dart';

const DEFAULT_PAGE = 1;

class PersonsCubit extends Cubit<PersonState> {
  final GetPopularPersonsUseCase popularPersonsUseCase;
  final ErrorHandler errorHandler;
  int page = DEFAULT_PAGE;

  PersonsCubit({
    required this.popularPersonsUseCase,
    required this.errorHandler,
  }) : super(PersonsEmpty());

  void loadPersons() async {
    if (state is PersonsLoading) return;
    final currentState = state;

    var oldPersonsList = <PersonEntity>[];

    if (currentState is PersonsLoaded) {
      oldPersonsList = currentState.personsList;
    }
    emit(PersonsLoading(oldPersonsList, isFirstFetch: page == DEFAULT_PAGE));
    final failureOrPersons = await popularPersonsUseCase(
      PageParams(page: page),
    );

    failureOrPersons.fold(
      (error) => emit(
        PersonError(errorMessage: errorHandler.mapFailureToMessage(error)),
      ),
      (list) {
        page++;
        final persons = (state as PersonsLoading).oldPersonsList;
        persons.addAll(list);
        emit(PersonsLoaded(persons));
      },
    );
  }
}
