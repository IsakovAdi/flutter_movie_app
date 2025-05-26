import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/core/error/exception.dart';
import 'package:movie_app/feature/data/models/movie/movie_dto.dart';
import 'package:movie_app/feature/data/utils/network_status.dart';
import 'package:movie_app/feature/data/utils/remote_utils.dart';

abstract class MovieDataSource {
  // Future<MovieResponseDto> getPopularMovies(int page);

  Future<List<MovieDto>> getNowPlayingMovies(int page);
  //
  // Future<MovieResponseDto> getUpcomingMovies(int page);
  //
  // Future<MovieResponseDto> getTopRatedMovies(int page);
}

class MovieDataSourceImpl extends MovieDataSource{
  final http.Client client;

  MovieDataSourceImpl({required this.client});

  @override
  Future<List<MovieDto>> getNowPlayingMovies(int page) async {
    final url = _getFullUrl(nowPlayingEndpoint, page);
    print(url);
    final response = await client.get(Uri.parse(url),
      headers: {'Content-type': 'application/json',
        "Authorization":authKey
      },);
    if(response.statusCode == statusSuccessful){
      final result = json.decode(response.body);
      return (result["results"] as List)
        .map((movie) => MovieDto.fromJson(movie)).toList();
    }else {
      throw ServerException();
    }
  }

  // @override
  // Future<MovieResponseDto> getPopularMovies(int page) {
  //   // TODO: implement getPopularMovies
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<MovieResponseDto> getTopRatedMovies(int page) {
  //   // TODO: implement getTopRatedMovies
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<MovieResponseDto> getUpcomingMovies(int page) {
  //   // TODO: implement getUpcomingMovies
  //   throw UnimplementedError();
  // }

  String _getFullUrl(String endpoint, int page) =>
      "$baseUrl$endpoint?language=$responseLanguage&page=$page";
}
