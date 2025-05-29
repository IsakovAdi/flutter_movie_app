import 'package:flutter/material.dart';
import 'package:movie_app/feature/domain/entities/people/person.dart';

import '../../../data/utils/remote_utils.dart';
import '../item_cache_image.dart';

class PersonCard extends StatelessWidget {
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

        child:getImageContainer(),
      ),
    );
  }

  Widget getImageContainer() {
    if (personEntity.image != posterPath) {
      return ItemCacheImage(
        imageUrl: "$posterPath${personEntity.image ?? ""}",
        width: 166,
        height: 280,
      );
    } else {
      return SizedBox(width: 166, height: 166, child: Card(
        child: Icon(Icons.person),
      ),);
    }
  }
}