import 'package:flutter/material.dart';
import 'package:flutter_movies_db_project/models/movie_videos_model.dart';
import 'package:flutter_movies_db_project/repositories/movie_repo.dart';

class MovieGetVideoProvider with ChangeNotifier {
  final MovieRepository _movieRepo;

  MovieGetVideoProvider(this._movieRepo);

  // bool _isLoading = false;
  // bool get isLoading => _isLoading;

  MovieVideosModel? _videos;
  MovieVideosModel? get videos => _videos;

  void getVideo(BuildContext context, {required int id}) async {
    _videos = null;
    notifyListeners();

    final result = await _movieRepo.getVideoMovie(id: id);

    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
      _videos = null;
      notifyListeners();
      return;
    }, (response) {
      _videos = response;
      notifyListeners();
      return null;
    });
  }
}
