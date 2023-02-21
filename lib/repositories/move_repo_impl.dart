import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_movies_db_project/models/movie_detail_model.dart';
import 'package:flutter_movies_db_project/models/movie_model_model.dart';
import 'package:flutter_movies_db_project/models/movie_videos_model.dart';

import 'movie_repo.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio;

  MovieRepositoryImpl(this._dio);

  @override
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result =
          await _dio.get('/discover/movie', queryParameters: {'page': page});

      if (result.statusCode == 200 || result.data != null) {
        final modelMovies = MovieResponseModel.fromMap(result.data);
        return Right(modelMovies);
      }

      return Left('Error get discover movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Error get discover movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1}) async {
    try {
      final result =
          await _dio.get('/movie/top_rated', queryParameters: {'page': page});

      if (result.statusCode == 200 || result.data != null) {
        final modelMovies = MovieResponseModel.fromMap(result.data);
        return Right(modelMovies);
      }

      return Left('Error get top rated movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Error get top rated movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getNowPlaying(
      {int page = 1}) async {
    try {
      final result =
          await _dio.get('/movie/now_playing', queryParameters: {'page': page});

      if (result.statusCode == 200 || result.data != null) {
        final modelMovies = MovieResponseModel.fromMap(result.data);
        return Right(modelMovies);
      }

      return Left('Error get now playing movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Error get now playing movies');
    }
  }

  @override
  Future<Either<String, MovieDetailModel>> getDetailMovie(
      {required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id',
      );

      if (result.statusCode == 200 || result.data != null) {
        final modelMovies = MovieDetailModel.fromMap(result.data);
        return Right(modelMovies);
      }

      return Left('Error get detail movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Error get detail movies');
    }
  }

  @override
  Future<Either<String, MovieVideosModel>> getVideoMovie(
      {required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id/videos',
      );

      if (result.statusCode == 200 || result.data != null) {
        final modelMovies = MovieVideosModel.fromJson(result.data);
        return Right(modelMovies);
      }

      return Left('Error get video movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Error get video movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> searchMovie(
      {required String query}) async {
    try {
      final result =
          await _dio.get('/search/movie', queryParameters: {'query': query});

      if (result.statusCode == 200 || result.data != null) {
        final modelMovies = MovieResponseModel.fromMap(result.data);
        return Right(modelMovies);
      }

      return Left('Error get now playing movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Error get now playing movies');
    }
  }
}
