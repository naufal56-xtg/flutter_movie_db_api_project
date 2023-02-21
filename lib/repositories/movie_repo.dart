import 'package:dartz/dartz.dart';
import 'package:flutter_movies_db_project/models/movie_detail_model.dart';
import 'package:flutter_movies_db_project/models/movie_model_model.dart';
import 'package:flutter_movies_db_project/models/movie_videos_model.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1});
  Future<Either<String, MovieResponseModel>> getNowPlaying({int page = 1});
  Future<Either<String, MovieResponseModel>> searchMovie(
      {required String query});
  Future<Either<String, MovieDetailModel>> getDetailMovie({required int id});
  Future<Either<String, MovieVideosModel>> getVideoMovie({required int id});
}
