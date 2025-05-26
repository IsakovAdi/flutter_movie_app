import 'package:equatable/equatable.dart';
import 'package:movie_app/feature/domain/entities/movie/genres_entity.dart';
import 'package:movie_app/feature/domain/entities/movie/product_companies.dart';

class MovieDetailsEntity extends Equatable {
  final bool adult;
  final String horizontalImage;
  final int budget;
  final List<Genres> genresList;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String description;
  final double popularity;
  final String verticalImage;
  final List<ProductCompaniesEntity> productCompaniesList;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;
  final String name;
  final int voteCount;
  final double vouteAverage;

  const MovieDetailsEntity({
    required this.adult,
    required this.horizontalImage,
    required this.budget,
    required this.genresList,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.description,
    required this.popularity,
    required this.verticalImage,
    required this.productCompaniesList,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.name,
    required this.voteCount,
    required this.vouteAverage,
  });

  @override
  List<Object?> get props => [
    adult,
    horizontalImage,
    budget,
    genresList,
    homepage,
    id,
    imdbId,
    originalLanguage,
    originalTitle,
    description,
    popularity,
    verticalImage,
    productCompaniesList,
    releaseDate,
    revenue,
    runtime,
    status,
    tagline,
    name,
    voteCount,
    vouteAverage,
  ];
}
