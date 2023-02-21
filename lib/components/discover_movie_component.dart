import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/pages/detail_movie_page.dart';
import 'package:provider/provider.dart';

import '../pages/widgets/item_movies_widget.dart';
import '../providers/movie_get_discover_provider.dart';

class DiscoverMovieComponent extends StatefulWidget {
  const DiscoverMovieComponent({super.key});

  @override
  State<DiscoverMovieComponent> createState() => _DiscoverMovieComponentState();
}

class _DiscoverMovieComponentState extends State<DiscoverMovieComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (provider.listMovies.isNotEmpty) {
            return CarouselSlider.builder(
                itemCount: provider.listMovies.length,
                itemBuilder: (_, index, __) {
                  final movie = provider.listMovies[index];
                  return ItemMovieWidget(
                    cipRadius: 20,
                    movie: movie,
                    heightBack: 300,
                    widthBack: double.infinity,
                    heightPoster: 180,
                    widthPoster: 110,
                    radius: 10,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMoviePage(id: movie.id),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 0.8,
                  reverse: false,
                  autoPlay: true,
                  // autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  // enlargeFactor: 0.3,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ));
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: Text(
                "Data Movies Discover Not Found",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
