import 'package:flutter/material.dart';
import 'package:movie_app/comon/app_colors.dart';
import 'package:movie_app/feature/presentation/widgets/movie/now_playing_movies_list_widget.dart';
import 'package:movie_app/feature/presentation/widgets/movie/popular_movies_list_widget.dart';
import 'package:movie_app/feature/presentation/widgets/movie/top_rated_movies_list_widget.dart';
import 'package:movie_app/feature/presentation/widgets/movie/upcoming_movies_list_widget.dart';

import '../../widgets/global_widgets.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40,),
          Container(
            width: double.maxFinite,
            child: TabBar(
              // isScrollable: true,
              labelColor: AppColors.colorAccent,
              indicatorColor: AppColors.colorAccent,
              controller: _tabController,
              unselectedLabelColor: Colors.grey,
              indicator: CircleTabIndicator(color: AppColors.colorAccent, radius: 4),
              tabs: [
                Tab(icon: Icon(Icons.shop_2_sharp), text: "Popular"),
                Tab(icon: Icon(Icons.star_rate_rounded), text: 'Top Rated'),
                Tab(
                  icon: Icon(Icons.screen_search_desktop_outlined),
                  text: "Now Playing",
                ),
                Tab(icon: Icon(Icons.upcoming_outlined), text: "Upcoming"),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 700,
            child: TabBarView(
              controller: _tabController,
                children: <Widget>[
              PopularMoviesListWidget(),
              TopRatedMoviesListWidget(),
              NowPlayingMovieListWidget(),
              UpcomingMoviesListWidget()
            ]),
          )
        ],
        // body: NowPlayingMovieListWidget(),
      ),
    );
  }
}
