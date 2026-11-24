import 'package:firebase_project/Movie%20App/models/movie_model.dart';
import 'package:firebase_project/Movie%20App/repositories/movie_repository.dart';
import 'package:flutter/foundation.dart';

class MovieViewmodel extends ChangeNotifier {
  final MovieRepository _repository;

  MovieViewmodel(this._repository);

  // Home page par by default 10 movies
  static const int defaultLimit = 10;

  List<MoviesList> _allMovies = [];

  bool _isLoading = false;
  String? _errorMessage;

  // Home page ke liye (sirf 10)
  List<MoviesList> get movies => _allMovies.take(defaultLimit).toList();

  // See All page ke liye (saari movies)
  List<MoviesList> get allMovies => _allMovies;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMovies() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allMovies = await _repository.getMovies();
    } catch (e) {
      debugPrint("Error: $e");
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
