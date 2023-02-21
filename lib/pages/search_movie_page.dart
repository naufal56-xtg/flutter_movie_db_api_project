import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/pages/detail_movie_page.dart';
import 'package:flutter_movies_db_project/pages/widgets/image_widget.dart';
import 'package:flutter_movies_db_project/providers/movie_search_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchPage extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Search Movies';

  // @override
  // InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
  //       hintStyle: TextStyle(color: Colors.white),
  //     );

  // @override
  // TextStyle? get searchFieldStyle => TextStyle(color: Colors.red);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.close,
          size: 24.0,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        size: 24.0,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieSearchProvider>().searchMovie(context, query: query);
    });

    return Consumer<MovieSearchProvider>(
      builder: (_, provider, __) {
        if (provider.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (query.isEmpty) {
          return Center(
            child: Text(
              "Search Movies",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          );
        }

        if (provider.listMovies.isEmpty) {
          return Center(
            child: Text(
              "Movie Not Found",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        if (provider.listMovies.isNotEmpty) {
          return ListView.separated(
            itemBuilder: (_, index) {
              final searchMovie = provider.listMovies[index];

              return Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, right: 10),
                    child: Row(
                      children: [
                        ImageWidget(
                          imageSrc: searchMovie.posterPath.toString(),
                          height: 155,
                          width: 100,
                          radius: 10,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                searchMovie.title,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_outlined,
                                    size: 24.0,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    searchMovie.voteAverage.toStringAsFixed(1),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                searchMovie.overview,
                                maxLines: 4,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.italic,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                      child: InkWell(onTap: () {
                        close(context, null);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailMoviePage(id: searchMovie.id),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              );
            },
            separatorBuilder: (_, index) => SizedBox(),
            itemCount: provider.listMovies.length,
          );
        }

        return Center(
          child: Text(
            "Another Error on Search Movies",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox();
  }
}
