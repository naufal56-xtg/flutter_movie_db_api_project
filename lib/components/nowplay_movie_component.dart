import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/pages/detail_movie_page.dart';
import 'package:flutter_movies_db_project/providers/movie_get_now_playing.dart';
import 'package:provider/provider.dart';

import '../pages/widgets/image_widget.dart';

class NowPlayMovieComponent extends StatefulWidget {
  const NowPlayMovieComponent({super.key});

  @override
  State<NowPlayMovieComponent> createState() => _NowPlayMovieComponentState();
}

class _NowPlayMovieComponentState extends State<NowPlayMovieComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetNowPlayingProvider>().getNowPlaying(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetNowPlayingProvider>(
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
                    final movie = provider.listMovies[index];
                    return Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.black45,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black45],
                            ),
                          ),
                          child: Row(
                            children: [
                              ImageWidget(
                                imageSrc: movie.posterPath.toString(),
                                height: 200,
                                width: 120,
                                radius: 15,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      movie.title.toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
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
                                          '${movie.voteAverage}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      movie.overview.toString(),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 6,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
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
                                  builder: (_) => DetailMoviePage(id: movie.id),
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
