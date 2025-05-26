import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/domain/entities/movie/movie_entity.dart';

class PersonEntity extends Equatable {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final double popularity;
  final String image;
  final List<MovieEntity> knownForMovies;

  const PersonEntity({
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
}
