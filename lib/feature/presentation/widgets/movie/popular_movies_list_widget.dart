import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/domain/entities/movie/movie_entity.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/popular_movies_cubit.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/state/movies_state.dart';
import 'package:movie_app/feature/presentation/widgets/movie/movie_card.dart';

import '../global_widgets.dart';

class PopularMoviesListWidget extends StatelessWidget {
  final scrollController = ScrollController();

  PopularMoviesListWidget({super.key});

  void _setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<PopularMoviesCubit>().loadMovies();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);

    return BlocBuilder<PopularMoviesCubit, MoviesState>(
      builder: (context, state) {
        List<MovieEntity> movies = [];
        bool isLoading = false;
        if (state is MoviesLoading && state.isFirstFetch) {
          return loadingIndicator();
        } else if (state is MoviesLoading) {
          movies = state.oldMoviesList;
          isLoading = true;
        } else if (state is MoviesLoaded) {
          movies = state.moviesList;
        } else if (state is MoviesError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
          );
        }

        return GridView.builder(
          controller: scrollController,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            if (index < movies.length) {
              return MovieCard(movies[index]);
            } else {
              Timer(Duration(milliseconds: 30), () {
                scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                );
              });
              return loadingIndicator();
            }
          },
          itemCount: movies.length + (isLoading ? 1 : 0),
        );
      },
    );
  }
}
