import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/comon/app_colors.dart';

import '../../../domain/entities/people/person.dart';
import '../../bloc/all_persons_cubit/person_cubit.dart';
import '../../bloc/all_persons_cubit/person_state.dart';
import '../../widgets/person/person_card.dart';

class PersonsPage extends StatefulWidget {
  const PersonsPage({super.key});

  @override
  State<PersonsPage> createState() => _PersonsPageState();
}

class _PersonsPageState extends State<PersonsPage> {
  String query = "";
  final scrollController = ScrollController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
  }

  void _setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (query.isNotEmpty) {
            context.read<PersonsCubit>().searchPersons(query);
          } else {
            context.read<PersonsCubit>().loadPersons();
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainBackground,
        title: Container(
          height: 38,
          child: Center(
            child: TextFormField(
              cursorColor: AppColors.colorAccent,
              controller: _nameController,
              onFieldSubmitted:
                  (value) => {
                    setState(() {
                      query = value;
                      context.read<PersonsCubit>().searchPersons(value);
                    }),
                  },
              onChanged:
                  (value) => {
                    if (value.isEmpty)
                      {
                        setState(() {
                          query = "";
                          context.read<PersonsCubit>().loadPersons();
                        }),
                      },
                  },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                contentPadding: EdgeInsets.only(left: 10, top: 0, bottom: 0),
                prefixIcon: Icon(Icons.search),
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (query.isNotEmpty) {
                      _nameController.clear();
                      setState(() {
                        query = "";
                        context.read<PersonsCubit>().loadPersons();
                      });
                    }
                  },
                  child: Icon(Icons.close, color: Colors.grey[800]),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Search person...",
                hintStyle: TextStyle(fontSize: 18, color: Colors.grey[800]),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: AppColors.mainBackground,
        child: BlocBuilder<PersonsCubit, PersonState>(
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
              itemBuilder: (context, index) {
                if (index < personsList.length) {
                  return PersonCard(personsList[index]);
                } else {
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
        ),
      ),
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
