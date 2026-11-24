// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'dart:convert';

MovieModel MovieModelFromJson(String str) =>
    MovieModel.fromJson(json.decode(str));
String MovieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
  List<MoviesList> movies;
  MovieModel({required this.movies});
  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    movies: List<MoviesList>.from(
      json["movies"].map((x) => MoviesList.fromJson(x)),
    ),
  );
  Map<String, dynamic> toJson() => {
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
  };
}

class MoviesList {
  String id;
  String title;
  String year;
  List<String> genres;
  List<int> ratings;
  String poster;
  String contentRating;
  String duration;
  String releaseDate;
  int averageRating;
  OriginalTitle originalTitle;
  String storyline;
  List<String> actors;
  dynamic imdbRating;
  String posterurl;
  MoviesList({
    required this.id,
    required this.title,
    required this.year,
    required this.genres,
    required this.ratings,
    required this.poster,
    required this.contentRating,
    required this.duration,
    required this.releaseDate,
    required this.averageRating,
    required this.originalTitle,
    required this.storyline,
    required this.actors,
    required this.imdbRating,
    required this.posterurl,
  });
  factory MoviesList.fromJson(Map<String, dynamic> json) => MoviesList(
    id: (json["id"]?.toString().trim() ?? '').isEmpty
        ? '-'
        : json["id"].toString().trim(),
    title: (json["title"]?.toString().trim() ?? '').isEmpty
        ? '-'
        : json["title"].toString().trim(),
    year: (json["year"]?.toString().trim() ?? '').isEmpty
        ? '-'
        : json["year"].toString().trim(),
    genres: List<String>.from(json["genres"] ?? []),
    ratings: List<int>.from(json["ratings"] ?? []),
    poster: (json["poster"]?.toString().trim() ?? '').isEmpty
        ? ''
        : json["poster"].toString().trim(),
    contentRating: (json["contentRating"]?.toString().trim() ?? '').isEmpty
        ? '-'
        : json["contentRating"].toString().trim(),
    duration: (json["duration"]?.toString().trim() ?? '').isEmpty
        ? '-'
        : json["duration"].toString().trim(),
    releaseDate: (json["releaseDate"]?.toString().trim() ?? '').isEmpty
        ? '-'
        : json["releaseDate"].toString().trim(),
    averageRating: int.tryParse(json["averageRating"]?.toString() ?? '') ?? 0,
    originalTitle: originalTitleValues.map[json["originalTitle"]]!,
    storyline: (json["storyline"]?.toString().trim() ?? '').isEmpty
        ? 'No storyline available'
        : json["storyline"].toString().trim(),
    actors: List<String>.from(json["actors"] ?? []),
    imdbRating: double.tryParse(json["imdbRating"]?.toString() ?? '') ?? 0.0,
    posterurl: (json["posterurl"]?.toString().trim() ?? '').isEmpty
        ? ''
        : json["posterurl"].toString().trim(),
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "year": year,
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "ratings": List<dynamic>.from(ratings.map((x) => x)),
    "poster": poster,
    "contentRating": contentRating,
    "duration": duration,
    "releaseDate": releaseDate,
    "averageRating": averageRating,
    "originalTitle": originalTitleValues.reverse[originalTitle],
    "storyline": storyline,
    "actors": List<dynamic>.from(actors.map((x) => x)),
    "imdbRating": imdbRating,
    "posterurl": posterurl,
  };
}

enum OriginalTitle {
  ANNIHILATION,
  A_WRINKLE_IN_TIME,
  CE_QUI_NOUS_LIE,
  EMPTY,
  THE_LEISURE_SEEKER,
}

final originalTitleValues = EnumValues({
  "Annihilation": OriginalTitle.ANNIHILATION,
  "A Wrinkle in Time": OriginalTitle.A_WRINKLE_IN_TIME,
  "Ce qui nous lie": OriginalTitle.CE_QUI_NOUS_LIE,
  "": OriginalTitle.EMPTY,
  "The Leisure Seeker": OriginalTitle.THE_LEISURE_SEEKER,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;
  EnumValues(this.map);
  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
