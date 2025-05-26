import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/domain/entities/movie/movie_entity.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesEmpty extends MoviesState {
  @override
  List<Object> get props => [];
}

class MoviesLoading extends MoviesState {
  final List<MovieEntity> oldMoviesList;
  final bool isFirstFetch;

  const MoviesLoading(
    this.oldMoviesList,{
    this.isFirstFetch = false,
  });

  @override
  List<Object> get props => [oldMoviesList];
}

class MoviesLoaded extends MoviesState {
  final List<MovieEntity> moviesList;

  const MoviesLoaded(
    this.moviesList,
  );
}

class MoviesError extends MoviesState {
  final String errorMessage;

  const MoviesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
