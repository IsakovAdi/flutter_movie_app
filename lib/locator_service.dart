import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/feature/data/datasource/remote/person/person_datasource.dart';
import 'package:movie_app/feature/data/mappers/person/person_mapper.dart';
import 'package:movie_app/feature/data/repository/movie/movie_repository_impl.dart';
import 'package:movie_app/feature/data/repository/person/person_repository.dart';
import 'package:movie_app/feature/domain/repository/movie/movie_repository.dart';
import 'package:movie_app/feature/domain/repository/person/person_repository.dart';
import 'package:movie_app/feature/domain/use_cases/person/persons_use_case.dart';
import 'package:movie_app/feature/presentation/bloc/error_handler.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/now_playing_movies_cubit.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/popular_movies_cubit.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/top_rated_movies_cubit.dart';
import 'package:movie_app/feature/presentation/bloc/movie_cubit/upcoming_movies_cubit.dart';
import 'package:movie_app/feature/presentation/bloc/search_persons_bloc/search_person_bloc.dart';

import 'core/platform/network_info.dart';
import 'feature/data/datasource/remote/movie/movie_data_source.dart';
import 'feature/data/mappers/movie_mappers/movie_mapper.dart';
import 'feature/domain/use_cases/movie/movie_use_cases.dart';
import 'feature/presentation/bloc/all_persons_cubit/person_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton(() => ErrorHandler());

  //  Bloc
  serviceLocator.registerFactory(
    () => NowPlayingMoviesCubit(
      nowPlayingMoviesUseCase: serviceLocator(),
      errorHandler: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => PopularMoviesCubit(
      getPopularMoviesUseCase: serviceLocator(),
      errorHandler: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => TopRatedMoviesCubit(
      getTopRatedMoviesUseCase: serviceLocator(),
      errorHandler: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UpcomingMoviesCubit(
      getUpcomingMoviesUseCase: serviceLocator(),
      errorHandler: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => PersonsCubit(
      popularPersonsUseCase: serviceLocator(),
      errorHandler: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => SearchPersonBloc(
      useCase: serviceLocator(),
      errorHandler: serviceLocator(),
    ),
  );

  // UseCases
  serviceLocator.registerLazySingleton(
    () => GetNowPlayingMoviesUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => GetPopularMoviesUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => GetTopRatedMoviesUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => GetUpcomingMoviesUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => GetPopularPersonsUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => SearchPersonUseCase(serviceLocator()),
  );

  // Mappers

  serviceLocator.registerLazySingleton(() => MovieMapper());
  serviceLocator.registerLazySingleton(() => PersonMapper(serviceLocator()));

  // DataSources
  serviceLocator.registerLazySingleton<MovieDataSource>(
    () => MovieDataSourceImpl(client: http.Client()),
  );

  serviceLocator.registerLazySingleton<PersonDataSource>(
    () => PersonDataSourceImpl(client: http.Client()),
  );

  // Repository
  serviceLocator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      networkInfo: serviceLocator(),
      dataSource: serviceLocator(),
      mapper: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      networkInfo: serviceLocator(),
      mapper: serviceLocator(),
      dataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
