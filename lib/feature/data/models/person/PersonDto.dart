import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/data/models/movie/movie_dto.dart';

class PersonDto extends Equatable {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final double popularity;
  final String image;
  final List<MovieDto> knownForMovies;

  const PersonDto({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.image,
    required this.knownForMovies,
  });

  @override
  List<Object> get props => [
    adult,
    gender,
    id,
    knownForDepartment,
    name,
    popularity,
    image,
    knownForMovies,
  ];

  factory PersonDto.fromJson(Map<String, dynamic> json) {
    return PersonDto(
      adult: json["adult"],
      gender: json["gender"],
      id: json["id"],
      knownForDepartment: json["known_for_department"],
      name: json["name"],
      popularity: json["popularity"],
      image: json["profile_path"],
      knownForMovies:
          (json["known_for"] as List<dynamic>)
              .map((movie) => MovieDto.fromJson(movie))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "adult": adult,
      "gender": gender,
      "id": id,
      "known_for_department": knownForDepartment,
      "name": name,
      "popularity": popularity,
      "profile_path": image,
      "known_for": knownForMovies,
    };
  }
}
