import 'package:dio/dio.dart';
import 'package:flutter_movies_db_project/providers/movie_get_detail.dart';
import 'package:flutter_movies_db_project/providers/movie_get_discover_provider.dart';
import 'package:flutter_movies_db_project/providers/movie_get_now_playing.dart';
import 'package:flutter_movies_db_project/providers/movie_get_toprated_provider.dart';
import 'package:flutter_movies_db_project/providers/movie_get_video.dart';
import 'package:flutter_movies_db_project/providers/movie_search_provider.dart';
import 'package:flutter_movies_db_project/repositories/move_repo_impl.dart';
import 'package:flutter_movies_db_project/repositories/movie_repo.dart';
import 'package:get_it/get_it.dart';

import '../app_const.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerFactory<MovieGetDiscoverProvider>(
    () => MovieGetDiscoverProvider(sl()),
  );
  sl.registerFactory<MovieGetTopRatedProvider>(
    () => MovieGetTopRatedProvider(sl()),
  );
  sl.registerFactory<MovieGetNowPlayingProvider>(
    () => MovieGetNowPlayingProvider(sl()),
  );
  sl.registerFactory<MovieGetDetailProvider>(
    () => MovieGetDetailProvider(sl()),
  );
  sl.registerFactory<MovieGetVideoProvider>(
    () => MovieGetVideoProvider(sl()),
  );
  sl.registerFactory<MovieSearchProvider>(
    () => MovieSearchProvider(sl()),
  );

  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));

  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppConst.baseUrl,
        queryParameters: {'api_key': AppConst.apiKey},
      ),
    ),
  );
}
