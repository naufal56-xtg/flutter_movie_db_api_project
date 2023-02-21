import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/movie_model_model.dart';
import '../repositories/movie_repo.dart';

class MovieGetTopRatedProvider with ChangeNotifier {
  final MovieRepository _movieRepo;

  MovieGetTopRatedProvider(this._movieRepo);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _listMovies = [];
  List<MovieModel> get listMovies => _listMovies;

  void getTopRated(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepo.getTopRated();

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

  void getTopRatedWithPaging(BuildContext context,
      {required PagingController pagingController, required int page}) async {
    final result = await _movieRepo.getTopRated(page: page);

    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );

      pagingController.error = errorMessage;

      return;
    }, (response) {
      if (response.results.length < 20) {
        pagingController.appendLastPage(response.results);
      } else {
        pagingController.appendPage(response.results, page + 1);
      }
      return null;
    });
  }
}
