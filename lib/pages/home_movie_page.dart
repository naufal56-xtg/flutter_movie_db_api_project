import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/components/discover_movie_component.dart';
import 'package:flutter_movies_db_project/components/nowplay_movie_component.dart';
import 'package:flutter_movies_db_project/components/toprated_movie_component.dart';
import 'package:flutter_movies_db_project/pages/paginate_movie.dart';
import 'package:flutter_movies_db_project/pages/search_movie_page.dart';

class HomeMovie extends StatelessWidget {
  const HomeMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Movies DB",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () =>
                    showSearch(context: context, delegate: MovieSearchPage()),
                icon: const Icon(
                  Icons.search,
                  size: 24.0,
                ),
              ),
            ],
            floating: true,
            snap: true,
            centerTitle: true,
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
          ),
          WidgetTitle(
            title: 'Discover Movies',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PaginateMovie(
                  type: TypeMovie.discover,
                ),
              ),
            ),
          ),
          DiscoverMovieComponent(),
          WidgetTitle(
            title: 'Top Rated Movies',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PaginateMovie(
                  type: TypeMovie.toprated,
                ),
              ),
            ),
          ),
          TopRatedMovieComponent(),
          WidgetTitle(
            title: 'Now Playing Movies',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PaginateMovie(
                  type: TypeMovie.toprated,
                ),
              ),
            ),
          ),
          NowPlayMovieComponent(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetTitle extends SliverToBoxAdapter {
  const WidgetTitle({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final void Function() onPressed;

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                shape: StadiumBorder(),
                side: BorderSide(
                  color: Colors.black,
                ),
              ),
              child: Text('See All'),
            ),
          ],
        ),
      );
}
