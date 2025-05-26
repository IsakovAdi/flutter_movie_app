import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/comon/app_colors.dart';
import 'package:movie_app/feature/domain/entities/people/person.dart';
import 'package:movie_app/feature/presentation/widgets/person/person_card.dart';

import '../../bloc/all_persons_cubit/person_cubit.dart';
import '../../bloc/all_persons_cubit/person_state.dart';

class PersonListWidget extends StatelessWidget {
  final scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<PersonsCubit>().loadPersons();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);

    return BlocBuilder<PersonsCubit, PersonState>(
      builder: (context, state) {
        List<PersonEntity> personsList = [];

        bool isLoading = false;
        if (state is PersonsLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonsLoading) {
          personsList = state.oldPersonsList;
          isLoading = true;
        } else if (state is PersonsLoaded) {
          personsList = state.personsList;
        } else if (state is PersonError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
          );
        }

        return GridView.builder(
          controller: scrollController,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index){
            if(index < personsList.length){
              return PersonCard(personsList[index]);
            }else{
              Timer(Duration(milliseconds: 30), () {
                scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                );
              });
              return _loadingIndicator();
            }
          },
          itemCount: personsList.length + (isLoading ? 1 : 0),
        );
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
}
