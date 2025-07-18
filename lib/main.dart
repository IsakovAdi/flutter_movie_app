import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/comon/app_colors.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/now_playing_movies_cubit.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/popular_movies_cubit.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/top_rated_movies_cubit.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/upcoming_movies_cubit.dart';
import 'package:movie_app/feature/presentation/bloc/search_persons_bloc/search_person_bloc.dart';

import 'feature/presentation/bloc/all_persons_cubit/person_cubit.dart';
import 'feature/presentation/pages/main_home_screen.dart';
import 'package:movie_app/locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesCubit>(
          create:
              (context) =>
                  di.serviceLocator<NowPlayingMoviesCubit>()..loadMovies(),
        ),
        BlocProvider<PopularMoviesCubit>(
          create:
              (context) =>
                  di.serviceLocator<PopularMoviesCubit>()..loadMovies(),
        ),
        BlocProvider<TopRatedMoviesCubit>(
          create:
              (context) =>
                  di.serviceLocator<TopRatedMoviesCubit>()..loadMovies(),
        ),
        BlocProvider<UpcomingMoviesCubit>(
          create:
              (context) =>
                  di.serviceLocator<UpcomingMoviesCubit>()..loadMovies(),
        ),
        BlocProvider<PersonsCubit>(
          create: (context) => di.serviceLocator<PersonsCubit>()..loadPersons(),
        ),
        BlocProvider<SearchPersonBloc>(
          create: (context) => di.serviceLocator<SearchPersonBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Moview App',
        theme: ThemeData.dark().copyWith(
          primaryColor: AppColors.mainBackground,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const MainHomePage(),
      ),
    );
  }
}
