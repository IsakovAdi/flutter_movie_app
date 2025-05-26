import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/domain/use_cases/params/params.dart';
import 'package:movie_app/feature/domain/use_cases/person/persons_use_case.dart';
import 'package:movie_app/feature/presentation/bloc/all_persons_cubit/person_state.dart';
import 'package:movie_app/feature/presentation/bloc/error_handler.dart';
import 'package:movie_app/feature/presentation/bloc/search_persons_bloc/search_person_event.dart';

class SearchPersonBloc extends Bloc<SearchPersonEvent, PersonState> {
  final SearchPersonUseCase useCase;
  final ErrorHandler errorHandler;

  SearchPersonBloc({required this.useCase, required this.errorHandler})
    : super(PersonsEmpty()) {
    on<SearchPersons>((event, emit) async {
      emit(PersonsEmpty());
      final failureOrPerson = await useCase(
        QueryAndPageParams(query: event.query, page: 1),
      );
      emit(
        failureOrPerson.fold(
          (failure) => PersonError(
            errorMessage: errorHandler.mapFailureToMessage(failure),
          ),
          (person) => PersonsLoaded(person),
        ),
      );
    });
  }
}
