import 'package:firebase_project/Movie%20App/repositories/movie_repository.dart';
import 'package:firebase_project/Movie%20App/services/movie_service.dart';
import 'package:firebase_project/Movie%20App/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

class MovieProvider {
  static List<ChangeNotifierProvider<MovieViewmodel>> movieProviders = [
    ChangeNotifierProvider<MovieViewmodel>(
      create: (_) =>
          MovieViewmodel(MovieRepository(MovieServices()))..fetchMovies(),
    ),
  ];
}
