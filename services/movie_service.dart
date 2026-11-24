import 'package:firebase_project/Movie%20App/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieServices {
  final String movieURL =
      "https://dea91516-1da3-444b-ad94-c6d0c4dfab81.mock.pstmn.io/movies_list";

  Future<List<MoviesList>> getMovies() async {
    try {
      final response = await http.get(Uri.parse(movieURL));

      if (response.statusCode == 200) {
        final movieModel = MovieModelFromJson(response.body);
        return movieModel.movies;
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      throw Exception("Error fetching movies: $e");
    }
  }
}
