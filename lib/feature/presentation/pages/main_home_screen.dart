import 'package:flutter/material.dart';
import 'package:movie_app/comon/app_colors.dart';
import 'package:movie_app/feature/presentation/pages/movie/movies_page.dart';
import 'package:movie_app/feature/presentation/pages/person/persons_page.dart';
import 'package:movie_app/feature/presentation/pages/movie/search_movie_page.dart';
import 'package:movie_app/feature/presentation/widgets/movie/movie_list_widget.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int selectedIndex = 0;

  List<Widget> pages = const [MoviesPage(), SearchMoviePage(), PersonsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[selectedIndex],
      ),
      backgroundColor: AppColors.mainBackground,
      // body: MovieListWidget(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.mainBackground,
        selectedItemColor: Colors.pink[600],
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            label: "Фильмы",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Поиск"),
          BottomNavigationBarItem(
            icon: Icon(Icons.recent_actors),
            label: "Актеры",
          ),
        ],
      ),
    );
  }
}
