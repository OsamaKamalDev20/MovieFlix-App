import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_project/Movie%20App/helper/movie_helper.dart';
import 'package:firebase_project/Movie%20App/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../themes/movies_colors.dart';

class MovieDetailView extends StatelessWidget {
  final MoviesList movie;

  const MovieDetailView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: movieScafColor,
      appBar: trendingMovieAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            // ================= POSTER HEADER =================
            trendingMoviePoster(),
            // Movie details will come here
            Padding(
              padding: const .symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 22,
                      color: moviePrimText,
                      fontWeight: .bold,
                    ),
                  ),
                  Text(
                    "${movie.year} • ${MovieHelper.formatDuration(movie.duration)}",
                    style: TextStyle(fontSize: 16, color: movieSecoText),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    spacing: 10,
                    children: List.generate(movie.genres.length, (index) {
                      final genre = movie.genres[index];
                      return Container(
                        padding: const .all(10),
                        decoration: BoxDecoration(
                          color: movieCard,
                          borderRadius: .circular(50),
                          border: .all(width: 1, color: movieSecoText),
                        ),
                        child: Text(
                          genre.isEmpty ? "No Genres Avalable" : genre,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: .w500,
                            color: moviePrimText,
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 15),
                  trendingMovieRating(),

                  const SizedBox(height: 15),
                  Row(
                    spacing: 15,
                    children: [
                      trendingMovieRelease(
                        "Release Date",
                        MovieHelper.formatReleaseDate(movie.releaseDate),
                        Icons.calendar_month_rounded,
                      ),
                      trendingMovieRelease(
                        "Duration",
                        MovieHelper.formatDuration(movie.duration),
                        Icons.alarm_rounded,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Text(
                    "Storyline",
                    style: TextStyle(
                      fontSize: 20,
                      color: moviePrimText,
                      fontWeight: .bold,
                    ),
                  ),
                  Text(
                    movie.storyline,
                    style: TextStyle(fontSize: 15, color: movieSecoText),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "Cast",
                        style: TextStyle(
                          fontSize: 20,
                          color: moviePrimText,
                          fontWeight: .bold,
                        ),
                      ),
                      Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 15,
                          color: moviePrimColor,
                          fontWeight: .w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  movie.actors.isEmpty
                      ? Text("-", style: TextStyle(color: movieSecoText))
                      : trendingMovieCasts(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: trendingMovieBottombar(context),
    );
  }

  SafeArea trendingMovieBottombar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const .all(15),
        child: ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  behavior: .floating,
                  backgroundColor: movieCard,
                  shape: RoundedRectangleBorder(
                    borderRadius: .circular(12),
                    side: BorderSide(color: moviePrimColor),
                  ),
                  content: Text(
                    "Trailer for ${movie.title} is coming soon",
                    style: TextStyle(color: moviePrimText),
                  ),
                  duration: const Duration(seconds: 3),
                ),
              );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: moviePrimColor,
            foregroundColor: moviePrimText,
            minimumSize: const Size(.infinity, 52),
            shape: RoundedRectangleBorder(borderRadius: .circular(12)),
          ),
          icon: const Icon(Icons.play_arrow_rounded, size: 24),
          label: const Text(
            "Watch Trailer",
            style: TextStyle(fontSize: 16, fontWeight: .w600),
          ),
        ),
      ),
    );
  }

  SizedBox trendingMovieCasts() {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: movie.actors.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final actor = movie.actors[index];
          return SizedBox(
            width: 90,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: moviePrimColor,
                  child: Text(
                    MovieHelper.getInitials(actor),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: .bold,
                      color: moviePrimText,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  actor,
                  maxLines: 2,
                  overflow: .ellipsis,
                  textAlign: .center,
                  style: TextStyle(
                    fontWeight: .w600,
                    color: moviePrimText,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container trendingMovieRelease(String title, value, IconData icon) {
    return Container(
      padding: const .all(15),
      decoration: BoxDecoration(borderRadius: .circular(12), color: movieCard),
      child: Column(
        spacing: 3,
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          Icon(icon, size: 24, color: moviePrimColor),
          Text(title, style: TextStyle(fontSize: 13, color: movieSecoText)),
          Text(value, style: TextStyle(fontSize: 16, color: moviePrimText)),
        ],
      ),
    );
  }

  IntrinsicHeight trendingMovieRating() {
    return IntrinsicHeight(
      child: Row(
        spacing: 12,
        crossAxisAlignment: .stretch,
        children: [
          // IMDb rating
          Expanded(
            child: Container(
              padding: const .all(12),
              decoration: BoxDecoration(
                color: movieCard,
                borderRadius: .circular(12),
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "(IMDb)",
                    style: TextStyle(fontSize: 13, color: movieSecoText),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    spacing: 4,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 26,
                        color: Colors.amber,
                      ),
                      Text(
                        movie.imdbRating == 0
                            ? 'N/A'
                            : movie.imdbRating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 22,
                          color: moviePrimText,
                          fontWeight: .w700,
                        ),
                      ),
                      Text(
                        " / 10",
                        style: TextStyle(color: movieSecoText, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // User ratings
          Expanded(
            child: Container(
              padding: const .all(12),
              decoration: BoxDecoration(
                color: movieCard,
                borderRadius: .circular(12),
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "User Ratings",
                    style: TextStyle(color: movieSecoText, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  FittedBox(
                    fit: .scaleDown,
                    alignment: .centerLeft,
                    child: Row(
                      children: [
                        RatingBarIndicator(
                          rating: MovieHelper.averageRating(movie.ratings),
                          itemCount: 5,
                          itemSize: 18,
                          unratedColor: Colors.grey.shade700,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star_rate_rounded,
                            color: moviePrimColor,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          MovieHelper.formatRating(movie.ratings),
                          style: TextStyle(
                            color: moviePrimText,
                            fontWeight: .w700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.ratings.isEmpty
                        ? "No ratings yet"
                        : "Based on ${movie.ratings.length} ratings",
                    style: TextStyle(color: movieSecoText, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox trendingMoviePoster() {
    return SizedBox(
      height: 380,
      width: .infinity,
      child: Stack(
        fit: .expand,
        children: [
          // Background Poster
          CachedNetworkImage(
            imageUrl: movie.posterurl,
            fit: .cover,
            errorWidget: (context, url, error) =>
                Icon(Icons.movie_rounded, size: 90, color: moviePrimColor),
          ),

          // Dark Gradient Overlay
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: .topCenter,
                end: .bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.45),
                  Colors.black.withValues(alpha: 0.75),
                  Colors.black.withValues(alpha: 0.95),
                ],
              ),
            ),
          ),
          Align(
            alignment: .centerLeft,
            child: Padding(
              padding: const .only(left: 15, top: 120),
              child: Hero(
                tag: movie.id,
                child: Container(
                  width: 140,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: .circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.6),
                        blurRadius: 25,
                        spreadRadius: 3,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: .circular(10),
                    child: CachedNetworkImage(
                      imageUrl: movie.posterurl,
                      fit: .cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(color: moviePrimColor),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.movie_rounded,
                        size: 60,
                        color: moviePrimColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar trendingMovieAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: moviePrimText),
      leading: Padding(
        padding: const .only(left: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: movieScafColor.withValues(alpha: .4),
            shape: .circle,
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_rounded, color: moviePrimText),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const .only(right: 8.0),
          child: Row(
            spacing: 10,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: movieScafColor.withValues(alpha: .4),
                  shape: .circle,
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border_rounded,
                    color: moviePrimText,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: movieScafColor.withValues(alpha: .4),
                  shape: .circle,
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(Icons.more_vert_rounded, color: moviePrimText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
