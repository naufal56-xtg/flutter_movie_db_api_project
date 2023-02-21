import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/models/movie_detail_model.dart';
import '../../models/movie_model_model.dart';
import 'image_widget.dart';

class ItemMovieWidget extends StatelessWidget {
  const ItemMovieWidget({
    Key? key,
    required this.heightBack,
    required this.widthBack,
    required this.heightPoster,
    required this.widthPoster,
    required this.radius,
    this.movie,
    this.onTap,
    this.movieDetailModel,
    required this.cipRadius,
  }) : super(key: key);

  final MovieModel? movie;
  final MovieDetailModel? movieDetailModel;
  final double heightBack;
  final double widthBack;
  final double heightPoster;
  final double widthPoster;
  final double radius;
  final void Function()? onTap;
  final double cipRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(cipRadius),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          ImageWidget(
            imageSrc: movieDetailModel != null
                ? movieDetailModel!.backdropPath.toString()
                : movie!.backdropPath.toString(),
            height: heightBack,
            width: widthBack,
          ),
          Container(
            height: heightBack,
            width: widthBack,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black45],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageWidget(
                  imageSrc: movieDetailModel != null
                      ? movieDetailModel!.backdropPath.toString()
                      : movie!.backdropPath.toString(),
                  height: heightPoster,
                  width: widthPoster,
                  radius: radius,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  movieDetailModel != null
                      ? movieDetailModel!.title
                      : movie!.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
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
                      movieDetailModel != null
                          ? '${movieDetailModel!.voteAverage.toStringAsFixed(1)} (${movieDetailModel!.voteCount})'
                          : '${movie!.voteAverage}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
