import '../models/movie_model.dart';
import '../services/movie_service.dart';

class MovieRepository {
  final MovieServices _movieService;

  MovieRepository(this._movieService);

  Future<List<MoviesList>> getMovies() async {
    return await _movieService.getMovies();
  }
}
