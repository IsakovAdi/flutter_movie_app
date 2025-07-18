import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/core/error/exception.dart';
import 'package:movie_app/feature/data/models/movie/movie_dto.dart';
import 'package:movie_app/feature/data/utils/network_status.dart';
import 'package:movie_app/feature/data/utils/remote_utils.dart';

abstract class MovieDataSource {
  Future<List<MovieDto>> getPopularMovies(int page);

  Future<List<MovieDto>> getNowPlayingMovies(int page);

  Future<List<MovieDto>> getUpcomingMovies(int page);

  Future<List<MovieDto>> getTopRatedMovies(int page);
}

class MovieDataSourceImpl extends MovieDataSource {
  final http.Client client;

  MovieDataSourceImpl({required this.client});

  Future<List<MovieDto>> _makeResponse(String endpoint, int page) async{
    final url = _getFullUrl(endpoint, page);
    print(url);
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-type': 'application/json', "Authorization": authKey},
    );
    if (response.statusCode == statusSuccessful) {
      final result = json.decode(response.body);
      return (result["results"] as List)
          .map((movie) => MovieDto.fromJson(movie))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieDto>> getNowPlayingMovies(int page) async {
    return _makeResponse(nowPlayingEndpoint, page);
  }

  @override
  Future<List<MovieDto>> getPopularMovies(int page) async {
   return _makeResponse(popularMoviesEndpoint, page);
  }

  @override
  Future<List<MovieDto>> getTopRatedMovies(int page) {
    return _makeResponse(topRatedMoviesEndpoint, page);
  }

  @override
  Future<List<MovieDto>> getUpcomingMovies(int page) {
   return _makeResponse(upcomingMoviesEndpoint, page);
  }

  String _getFullUrl(String endpoint, int page) =>
      "$baseUrl$endpoint?language=$responseLanguage&page=$page";
}
