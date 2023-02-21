// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/app_const.dart';

enum TypeSrcImg { movieDB, external }

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    // required this.movie,
    required this.imageSrc,
    this.height,
    this.width,
    this.radius = 0.0,
    this.type = TypeSrcImg.movieDB,
  }) : super(key: key);

  // final MovieModel movie;
  final String imageSrc;
  final double? height;
  final double? width;
  final double radius;
  final TypeSrcImg type;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.network(
            fit: BoxFit.cover,
            height: height,
            width: width,
            type == TypeSrcImg.movieDB
                ? '${AppConst.imageW500}/$imageSrc'
                : imageSrc,
            loadingBuilder: (context, child, loadingProgress) {
              return Container(
                height: height,
                width: width,
                color: Colors.black38,
                child: child,
              );
            },
            errorBuilder: (context, error, stackTrace) => SizedBox(
              height: height,
              width: width,
              child: Icon(Icons.broken_image_rounded),
            ),
          ),
        ),
      ],
    );
  }
}
