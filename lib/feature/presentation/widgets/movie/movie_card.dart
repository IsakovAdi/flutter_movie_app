import 'package:flutter/material.dart';
import 'package:movie_app/feature/data/utils/remote_utils.dart';
import 'package:movie_app/feature/domain/entities/movie/movie_entity.dart';
import 'package:movie_app/feature/presentation/widgets/item_cache_image.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movieEntity;

  const MovieCard(this.movieEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),

        child: ItemCacheImage(
          imageUrl: "$posterPath${movieEntity.posterImage ?? ""}",
          width: 166,
          height: 280,
        ),
      ),
    );
  }
}
