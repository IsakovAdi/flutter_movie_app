import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/data/utils/remote_utils.dart';
import 'package:movie_app/feature/domain/use_cases/movie/movie_use_cases.dart';
import 'package:movie_app/feature/presentation/bloc/error_handler.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/state/movies_state.dart';

import '../../../domain/entities/movie/movie_entity.dart';
import '../../../domain/use_cases/params/params.dart';

class PopularMoviesCubit extends Cubit<MoviesState>{
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final ErrorHandler errorHandler;
  int page = 1;

  PopularMoviesCubit({required this.getPopularMoviesUseCase, required this.errorHandler}):super(MoviesEmpty());

  void loadMovies() async {
    if (state is MoviesLoading) return;
    final currentState = state;

    var oldMovies = <MovieEntity>[];

    if (currentState is MoviesLoaded) {
      oldMovies = currentState.moviesList;
    }
    emit(MoviesLoading(oldMovies, isFirstFetch: page == 1));
    final failureOrMovies = await getPopularMoviesUseCase(
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