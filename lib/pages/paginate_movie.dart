import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/pages/widgets/item_movies_widget.dart';
import 'package:flutter_movies_db_project/providers/movie_get_discover_provider.dart';
import 'package:flutter_movies_db_project/providers/movie_get_toprated_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_movies_db_project/models/movie_model_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'detail_movie_page.dart';

enum TypeMovie { discover, toprated }

class PaginateMovie extends StatefulWidget {
  const PaginateMovie({super.key, required this.type});

  final TypeMovie type;

  @override
  State<PaginateMovie> createState() => _PaginateMovieState();
}

class _PaginateMovieState extends State<PaginateMovie> {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      context.read<MovieGetDiscoverProvider>().getDiscoverWithPaging(context,
          pagingController: _pagingController, page: pageKey);
      switch (widget.type) {
        case TypeMovie.discover:
          context.read<MovieGetDiscoverProvider>().getDiscoverWithPaging(
              context,
              pagingController: _pagingController,
              page: pageKey);
          break;
        case TypeMovie.toprated:
          context.read<MovieGetTopRatedProvider>().getTopRatedWithPaging(
              context,
              pagingController: _pagingController,
              page: pageKey);
          break;
        default:
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (_) {
            switch (widget.type) {
              case TypeMovie.discover:
                return Text('List Discover Movies');
              case TypeMovie.toprated:
                return Text('List Top Rated Movies');
            }
          },
        ),
        backgroundColor: Colors.black87,
      ),
      body: PagedListView.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieModel>(
          itemBuilder: (context, item, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ItemMovieWidget(
                cipRadius: 20,
                movie: item,
                heightBack: 260,
                widthBack: double.infinity,
                heightPoster: 140,
                widthPoster: 80,
                radius: 10,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailMoviePage(id: item.id),
                  ),
                ),
              ),
            );
          },
        ),
        separatorBuilder: (context, index) {
          return SizedBox();
        },
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
