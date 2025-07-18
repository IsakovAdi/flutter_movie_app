
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/domain/use_cases/movie/movie_use_cases.dart';

import '../../../domain/entities/movie/movie_entity.dart';
import '../../../domain/use_cases/params/params.dart';
import '../error_handler.dart';
import 'state/movies_state.dart';

class UpcomingMoviesCubit extends Cubit<MoviesState>{
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;
  final ErrorHandler errorHandler;
  int page = 1;

  UpcomingMoviesCubit({required this.getUpcomingMoviesUseCase, required this.errorHandler}):super(MoviesEmpty());

  void loadMovies() async {
    if (state is MoviesLoading) return;
    final currentState = state;

    var oldMovies = <MovieEntity>[];

    if (currentState is MoviesLoaded) {
      oldMovies = currentState.moviesList;
    }
    emit(MoviesLoading(oldMovies, isFirstFetch: page == 1));
    final failureOrMovies = await getUpcomingMoviesUseCase(
      PageParams(page: page),
    );

    failureOrMovies.fold(
          (error) => emit(MoviesError(errorMessage: errorHandler.mapFailureToMessage(error))),
          (list) {
        page++;
        final movies = (state as MoviesLoading).oldMoviesList;
        movies.addAll(list);
        emit(MoviesLoaded(movies));
      },
    );
  }
}