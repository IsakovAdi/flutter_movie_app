import 'package:equatable/equatable.dart';

class PageParams extends Equatable {
  final int page;

  const PageParams({required this.page});

  @override
  List<Object?> get props => [page];
}

class QueryAndPageParams extends Equatable {
  final String query;
  final int page;

  const QueryAndPageParams({required this.query, required this.page});

  @override
  // TODO: implement props
  List<Object?> get props => [query, page];
}
