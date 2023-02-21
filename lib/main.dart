import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/pages/home_movie_page.dart';
import 'package:flutter_movies_db_project/pages/inject.dart';
import 'package:flutter_movies_db_project/providers/movie_get_discover_provider.dart';
import 'package:flutter_movies_db_project/providers/movie_get_now_playing.dart';
import 'package:flutter_movies_db_project/providers/movie_get_toprated_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'providers/movie_search_provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetTopRatedProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetNowPlayingProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieSearchProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movies App DB',
        debugShowCheckedModeBanner: false,
        home: HomeMovie(),
      ),
    );
  }
}
