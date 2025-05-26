import 'package:flutter/material.dart';
import 'package:movie_app/comon/app_colors.dart';
import 'package:movie_app/feature/presentation/widgets/movie/movie_list_widget.dart';

class MoviesPage extends StatelessWidget{
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: MovieListWidget(),
    );
  }
}