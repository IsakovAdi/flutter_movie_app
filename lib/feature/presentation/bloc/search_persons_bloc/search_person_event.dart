import 'package:equatable/equatable.dart';

abstract class SearchPersonEvent extends Equatable {
  const SearchPersonEvent();

  @override
  List<Object> get props => [];
}

class SearchPersons extends SearchPersonEvent {
  final String query;
  final page = 1;

  const SearchPersons(this.query);
}
