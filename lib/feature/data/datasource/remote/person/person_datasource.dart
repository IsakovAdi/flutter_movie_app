import 'dart:convert';

import 'package:movie_app/core/error/exception.dart';
import 'package:movie_app/feature/data/models/person/PersonDto.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/feature/data/utils/network_status.dart';
import 'package:movie_app/feature/data/utils/remote_utils.dart';

abstract class PersonDataSource {
  Future<List<PersonDto>> getPopularPersons(int page);

  Future<List<PersonDto>> searchPerson(String personName, int page);
}

class PersonDataSourceImpl implements PersonDataSource {
  final http.Client client;

  PersonDataSourceImpl({required this.client});

  @override
  Future<List<PersonDto>> getPopularPersons(int page) async {
    final url = "$baseUrl$allPersonsEndpoint$page";
    final response = await client.get(
      Uri.parse(url),
      headers: {"accept": "application/json", "Authorization": authKey},
    );

    if (response.statusCode == statusSuccessful) {
      final result = json.decode(response.body);
      return (result["results"] as List)
          .map((person) => PersonDto.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PersonDto>> searchPerson(String personName, int page) async {
    final url =
        "$baseUrl$searchPersonEndpoint$personName&include_adult=false&language=$responseLanguage&page=$page";
    final response = await client.get(
      Uri.parse(url),
      headers: {"accept": "application/json", "Authorization": authKey},
    );

    if (response.statusCode == statusSuccessful) {
      final result = json.decode(response.body);
      return (result["results"] as List)
          .map((person) => PersonDto.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
