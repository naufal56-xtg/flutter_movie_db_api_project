import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/pages/inject.dart';
import 'package:flutter_movies_db_project/pages/widgets/image_widget.dart';
import 'package:flutter_movies_db_project/pages/widgets/item_movies_widget.dart';
import 'package:flutter_movies_db_project/pages/widgets/webview_widget.dart';
import 'package:flutter_movies_db_project/pages/widgets/yotube_player_widget.dart';
import 'package:flutter_movies_db_project/providers/movie_get_detail.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../providers/movie_get_video.dart';

class DetailMoviePage extends StatelessWidget {
  const DetailMoviePage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              sl<MovieGetDetailProvider>()..getDetailMovie(context, id: id),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetVideoProvider>()..getVideo(context, id: id),
        )
      ],
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            AppBarWidget(),
            Consumer<MovieGetVideoProvider>(
              builder: (_, provider, __) {
                final video = provider.videos;

                if (video != null) {
                  return SliverToBoxAdapter(
                    child: _Content(
                        title: 'Trailer',
                        body: SizedBox(
                          height: 200,
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            scrollDirection: Axis.horizontal,
                            itemCount: video.results.length,
                            itemBuilder: (_, index) {
                              final resultVideo = video.results[index];
                              return Stack(
                                children: [
                                  ImageWidget(
                                    width: MediaQuery.of(context).size.width *
                                        0.92,
                                    radius: 12,
                                    type: TypeSrcImg.external,
                                    imageSrc: YoutubePlayer.getThumbnail(
                                        videoId: resultVideo.key),
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: const Icon(
                                          Icons.play_arrow_sharp,
                                          size: 40.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => YoutubePlayerWidget(
                                                youtubeKey: resultVideo.key),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 15,
                            ),
                          ),
                        ),
                        padding: 0),
                  );
                }
                return SliverToBoxAdapter();
              },
            ),
            _WidgetSummary(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Padding(
        padding: EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24.0,
            ),
          ),
        ),
      ),
      actions: [
        Consumer<MovieGetDetailProvider>(
          builder: (_, value2, __) {
            final detailMovie = value2.movie;

            if (detailMovie != null) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WebViewState(
                            title: detailMovie.title,
                            url: detailMovie.homepage),
                      ),
                    ),
                    icon: const Icon(
                      Icons.public,
                      color: Colors.black,
                      size: 24.0,
                    ),
                  ),
                ),
              );
            }
            return SizedBox();
          },
        )
      ],
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      expandedHeight: 300,
      flexibleSpace: Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final detailMovie = provider.movie;

          if (detailMovie != null) {
            return ItemMovieWidget(
              cipRadius: 0,
              movieDetailModel: detailMovie,
              heightBack: double.infinity,
              widthBack: double.infinity,
              heightPoster: 140,
              widthPoster: 160,
              radius: 0,
            );
          }

          return Container(
            color: Colors.black12,
            height: double.infinity,
            width: double.infinity,
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content(
      {required this.title, required this.body, required this.padding});

  final String title;
  final Widget body;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 8.0,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: body,
        ),
      ],
    );
  }
}

class _WidgetSummary extends SliverToBoxAdapter {
  TableRow _tableContent({required String title, required String content}) =>
      TableRow(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '$title',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              content,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );

  @override
  Widget? get child => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Content(
                  title: 'Release Date',
                  body: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        size: 32.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        movie.releaseDate.toString().split(' ').first,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  padding: 15,
                ),
                _Content(
                  padding: 15,
                  title: 'Genres',
                  body: Wrap(
                    spacing: 6,
                    children: movie.genres
                        .map((genre) => Text(
                              '${genre.name},',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ))
                        .toList(),
                  ),
                ),
                _Content(
                  title: 'Overview',
                  body: Text(
                    movie.overview,
                    textAlign: TextAlign.justify,
                  ),
                  padding: 15,
                ),
                _Content(
                  padding: 15,
                  title: 'Summary',
                  body: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    children: [
                      _tableContent(
                        title: "Adult",
                        content: movie.adult ? "Yes" : "No",
                      ),
                      _tableContent(
                        title: "Popularity",
                        content: '${movie.popularity}',
                      ),
                      _tableContent(
                        title: "Status",
                        content: movie.status,
                      ),
                      _tableContent(
                        title: "Budget",
                        content: "${movie.budget}",
                      ),
                      _tableContent(
                        title: "Revenue",
                        content: "${movie.revenue}",
                      ),
                      _tableContent(
                        title: "Tagline",
                        content: movie.tagline,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      );
}
// class _WidgetAppBar extends SliverAppBar {
//   @override
//   Color? get backgroundColor => Colors.white;

//   @override
//   Color? get foregroundColor => Colors.black;

//   @override
//   double? get expandedHeight => 300;

//   @override
//   Widget? get flexibleSpace => Consumer<MovieGetDetailProvider>(
//         builder: (_, provider, __) {
//           final detailMovie = provider.movie;

//           if (detailMovie != null) {
//             return ItemMovieWidget(
//               cipRadius: 0,
//               movieDetailModel: detailMovie,
//               heightBack: double.infinity,
//               widthBack: double.infinity,
//               heightPoster: 140,
//               widthPoster: 160,
//               radius: 0,
//             );
//           }

//           return Container(
//             color: Colors.black12,
//             height: double.infinity,
//             width: double.infinity,
//           );
//         },
//       );
// }
