import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/models/movie_model_model.dart';
import 'package:flutter_movies_db_project/repositories/movie_repo.dart';

class MovieSearchProvider with ChangeNotifier {
  final MovieRepository _movieRepo;

  MovieSearchProvider(this._movieRepo);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _listMovies = [];
  List<MovieModel> get listMovies => _listMovies;

  void searchMovie(BuildContext context, {required String query}) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepo.searchMovie(query: query);

    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
      _isLoading = false;
      notifyListeners();
      return;
    }, (response) {
      _listMovies.clear();
      _listMovies.addAll(response.results);
      _isLoading = false;
      notifyListeners();
      return null;
    });
  }
}
