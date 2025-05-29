import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/domain/entities/people/person.dart';
import 'package:movie_app/feature/domain/use_cases/params/params.dart';
import 'package:movie_app/feature/domain/use_cases/person/persons_use_case.dart';
import 'package:movie_app/feature/presentation/bloc/all_persons_cubit/person_state.dart';
import 'package:movie_app/feature/presentation/bloc/error_handler.dart';

const DEFAULT_PAGE = 1;

enum LastResponse{
  SEARCH_PERSONS,
  GET_POPULAR_PERSONS
}

class PersonsCubit extends Cubit<PersonState> {
  final GetPopularPersonsUseCase popularPersonsUseCase;
  final SearchPersonUseCase searchPersonUseCase;
  final ErrorHandler errorHandler;
  int page = DEFAULT_PAGE;
  bool isSearching = false;
  LastResponse lastResponse = LastResponse.GET_POPULAR_PERSONS;


  PersonsCubit({
    required this.searchPersonUseCase,
    required this.popularPersonsUseCase,
    required this.errorHandler,
  }) : super(PersonsEmpty());

  void loadPersons() async {
    print("load persons ${page.toString()}");

    if (state is PersonsLoading) return;
    final currentState = state;

    var oldPersonsList = <PersonEntity>[];

    if (currentState is PersonsLoaded && lastResponse == LastResponse.GET_POPULAR_PERSONS) {
      oldPersonsList = currentState.personsList;
    }else{
      lastResponse = LastResponse.GET_POPULAR_PERSONS;
      page = DEFAULT_PAGE;
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

  void searchPersons(String personName) async{
    print(personName);
    print(page.toString());

    if (state is PersonsLoading) return;
    final currentState = state;

    var oldPersonsList = <PersonEntity>[];

    if (currentState is PersonsLoaded && lastResponse == LastResponse.SEARCH_PERSONS) {
      oldPersonsList = currentState.personsList;
    }else{
      lastResponse = LastResponse.SEARCH_PERSONS;
      page = DEFAULT_PAGE;
    }
    emit(PersonsLoading(oldPersonsList, isFirstFetch: page == DEFAULT_PAGE));

    final failureOrPersons = await searchPersonUseCase(
      QueryAndPageParams(query: personName, page: page),
    );

    failureOrPersons.fold(  (error) => emit(
      PersonError(errorMessage: errorHandler.mapFailureToMessage(error)),
    ), (list){
      page++;
      final persons = (state as PersonsLoading).oldPersonsList;
      persons.addAll(list);
      emit(PersonsLoaded(persons));
    });
  }
}
