import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/models/movie_detail_model.dart';
import 'package:flutter_movies_db_project/repositories/movie_repo.dart';

class MovieGetDetailProvider with ChangeNotifier {
  final MovieRepository _movieRepo;

  MovieGetDetailProvider(this._movieRepo);

  // bool _isLoading = false;
  // bool get isLoading => _isLoading;

  MovieDetailModel? _movie;
  MovieDetailModel? get movie => _movie;

  void getDetailMovie(BuildContext context, {required int id}) async {
    _movie = null;
    notifyListeners();

    final result = await _movieRepo.getDetailMovie(id: id);

    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
      _movie = null;
      notifyListeners();
      return;
    }, (response) {
      _movie = response;
      notifyListeners();
      return null;
    });
  }
}
