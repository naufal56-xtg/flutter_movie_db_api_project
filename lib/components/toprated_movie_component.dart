import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/detail_movie_page.dart';
import '../pages/widgets/image_widget.dart';
import '../providers/movie_get_toprated_provider.dart';

class TopRatedMovieComponent extends StatefulWidget {
  const TopRatedMovieComponent({super.key});

  @override
  State<TopRatedMovieComponent> createState() => _TopRatedMovieComponentState();
}

class _TopRatedMovieComponentState extends State<TopRatedMovieComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetTopRatedProvider>().getTopRated(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetTopRatedProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (provider.listMovies.isNotEmpty) {
            return SizedBox(
              height: 200,
              width: 120,
              child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Stack(
                      children: [
                        ImageWidget(
                          imageSrc:
                              provider.listMovies[index].posterPath.toString(),
                          height: 200,
                          width: 120,
                          radius: 15,
                        ),
                        Container(
                          height: 200,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.transparent, Colors.black45],
                            ),
                          ),
                        ),
                        Positioned(
                          // bottom: 5,
                          right: 10,
                          top: 10,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_outlined,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${provider.listMovies[index].voteAverage}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailMoviePage(
                                      id: provider.listMovies[index].id),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(
                        width: 5,
                      ),
                  itemCount: provider.listMovies.length),
            );
          }
          return Container(
            child: Center(
              child: Text(
                "Data Movies Top Rated Not Found",
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
