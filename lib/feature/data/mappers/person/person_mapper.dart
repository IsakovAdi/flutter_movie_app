import 'package:movie_app/feature/data/mappers/movie_mappers/movie_mapper.dart';
import 'package:movie_app/feature/data/models/person/PersonDto.dart';
`import 'package:movie_app/feature/domain/entities/movie/movie_entity.dart';
import 'package:movie_app/feature/domain/entities/people/person.dart';

class PersonMapper {
  final MovieMapper mapper;

  const PersonMapper(this.mapper);

  PersonEntity mapFromDto(PersonDto from) {


    return PersonEntity(
      adult: from.adult??false,
      gender: from.gender??1,
      id: from.id??0,
      knownForDepartment: from.knownForDepartment??"",
      name: from.name??"",
      popularity: from.popularity??0,
      image: from.image??"",
      knownForMovies:from.knownForMovies?.map((movie) => mapper.mapFromDto(movie)).toList()??[],
    );
  }

  PersonDto mapToDto(PersonEntity from) {
    return PersonDto(
      adult: from.adult,
      gender: from.gender,
      id: from.id,
      knownForDepartment: from.knownForDepartment,
      name: from.name,
      popularity: from.popularity,
      image: from.image,
      knownForMovies:
          from.knownForMovies.map((movie) => mapper.mapToDto(movie)).toList(),
    );
  }
}
