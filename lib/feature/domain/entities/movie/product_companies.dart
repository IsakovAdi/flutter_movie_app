import 'package:equatable/equatable.dart';

class ProductCompaniesEntity extends Equatable {
  final int id;
  final String logo;
  final String name;
  final String country;

  const ProductCompaniesEntity({
    required this.id,
    required this.logo,
    required this.name,
    required this.country,
  });

  @override
  List<Object> get props => [id, logo, name, country];
}
