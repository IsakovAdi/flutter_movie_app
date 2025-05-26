import 'package:flutter/material.dart';
import 'package:movie_app/comon/app_colors.dart';
import 'package:movie_app/feature/presentation/widgets/person/person_list_widget.dart';

import '../../widgets/person/custom_search_person_delegate.dart';

class PersonsPage extends StatelessWidget {
  const PersonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        title: Text("Актеры", style: TextStyle(color: AppColors.colorAccent)),
        backgroundColor: Colors.black,
        centerTitle: true,
        shadowColor: AppColors.mainBackground,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchPersonDelegate(),
              );
            },
          ),
        ],
        surfaceTintColor: AppColors.mainBackground,
      ),
      body: PersonListWidget(),
    );
  }
}
