import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/domain/entities/movie/movie_entity.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/movies_cubit.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/movies_state.dart';
import 'package:movie_app/feature/presentation/widgets/movie/movie_card.dart';

class MovieListWidget extends StatelessWidget {
  final scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<MoviesCubit>().loadMovies();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);

    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        List<MovieEntity> movies = [];
        bool isLoading = false;
        if (state is MoviesLoading && state.isFirstFetch) {
          return _loadingIndicator();
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
              return _loadingIndicator();
            }
          },
          itemCount: movies.length + (isLoading ? 1 : 0),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
