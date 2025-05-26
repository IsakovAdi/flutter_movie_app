import 'package:flutter/material.dart';
import 'package:movie_app/feature/domain/entities/people/person.dart';

import '../../../data/utils/remote_utils.dart';
import '../item_cache_image.dart';

class PersonCard extends StatelessWidget{
  final PersonEntity personEntity;

  const PersonCard(this.personEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),

        child: ItemCacheImage(
          imageUrl: "$posterPath${personEntity.image ?? ""}",
          width: 166,
          height: 280,
        ),
      ),
    );
  }


}