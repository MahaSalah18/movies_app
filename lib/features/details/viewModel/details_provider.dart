import 'package:flutter/material.dart';
import 'package:movies_app/data/models/cast_model.dart';

import '../../../data/services/movie_repo.dart';

class DetailsProvider extends ChangeNotifier {
  final MovieRepo repository;
  DetailsProvider(this.repository);

  List<CastMember> cast = [];
  bool isLoadingCast = false;

  Future<void> fetchCast(int movieId) async {
    isLoadingCast = true;
    notifyListeners();

    try {
      cast = await repository.fetchMovieCredits(movieId);
    } catch (e) {
      cast = [];
    } finally {
      isLoadingCast = false;
      notifyListeners();
    }
  }

  void clearCast() {
    cast = [];
    notifyListeners();
  }
}
