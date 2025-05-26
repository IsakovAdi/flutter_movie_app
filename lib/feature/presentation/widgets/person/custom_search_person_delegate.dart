import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/presentation/bloc/all_persons_cubit/person_state.dart';
import 'package:movie_app/feature/presentation/bloc/search_persons_bloc/search_person_bloc.dart';
import 'package:movie_app/feature/presentation/bloc/search_persons_bloc/search_person_event.dart';
import 'package:movie_app/feature/presentation/widgets/person/person_card.dart';

import '../../../../comon/app_colors.dart';
import '../../../domain/entities/people/person.dart';

class CustomSearchPersonDelegate extends SearchDelegate {
  CustomSearchPersonDelegate() : super(searchFieldLabel: "Search actors");

  final _suggestions = [
    "Том Круз",
    "Джейсон Стэтхэм",
    "Киану Ривз",
    "Том Харди",
  ];

  final scrollController = ScrollController();

  // void _setupScrollController(BuildContext context) {
  //   scrollController.addListener(() {
  //     if (scrollController.position.atEdge) {
  //       if (scrollController.position.pixels != 0) {
  //         context.read<SearchPersonCubit>().searchPersons(query);
  //       }
  //     }
  //   });
  // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back_outlined),
      tooltip: "Back",
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // _setupScrollController(context);
    BlocProvider.of<SearchPersonBloc>(context, listen: false)
      ..add(SearchPersons(query));
    return BlocBuilder<SearchPersonBloc, PersonState>(
      builder: (context, state) {
        if (state is PersonsLoading) {
          return _loadingIndicator();
        } else if (state is PersonsLoaded) {
          final personsList = state.personsList;
          if (personsList.isEmpty) {
            return Center(child: Icon(Icons.now_wallpaper));
          }
          return GridView.builder(
            // controller: scrollController,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return PersonCard(personsList[index]);
            },
            itemCount: personsList.length,
          );
        } else if (state is PersonError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
          );
        } else {
          return Center(child: Icon(Icons.now_wallpaper));
        }
      },
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.colorAccent),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 0) {
      return Container();
    }
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Text(
          _suggestions[index],
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: _suggestions.length,
    );
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Text(
        errorMessage,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
