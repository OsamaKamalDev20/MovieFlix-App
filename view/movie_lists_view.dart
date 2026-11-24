import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_project/Movie%20App/helper/movie_helper.dart';
import 'package:firebase_project/Movie%20App/themes/movies_colors.dart';
import 'package:firebase_project/Movie%20App/view/movie_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/movie_viewmodel.dart';

class TrendingMovieListsView extends StatelessWidget {
  const TrendingMovieListsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: movieScafColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Trending Movies Lists",
          style: TextStyle(
            fontSize: 20,
            color: moviePrimText,
            fontWeight: .bold,
          ),
        ),
        iconTheme: const IconThemeData(color: moviePrimText),
      ),
      body: Consumer<MovieViewmodel>(
        builder: (context, viewModel, child) {
          // Loading State
          if (viewModel.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: moviePrimColor,
              ),
            );
          }

          // Empty Data
          if (viewModel.allMovies.isEmpty) {
            return Center(
              child: Text(
                "No movies available",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: .w500,
                  color: moviePrimText,
                ),
              ),
            );
          }

          // Success Response
          return GridView.builder(
            padding: const .all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.7,
            ),
            itemCount: viewModel.allMovies.length,
            itemBuilder: (context, index) {
              final movie = viewModel.allMovies[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailView(movie: movie),
                  ),
                ),
                child: Card(
                  elevation: 8,
                  color: movieCard,
                  shadowColor: moviePrimColor.withValues(alpha: 0.3),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: .start,
                    children: [
                      Expanded(
                        child: Hero(
                          tag: movie.id,
                          child: SizedBox(
                            width: .infinity,
                            child: ClipRRect(
                              borderRadius: const .vertical(top: .circular(10)),
                              child: CachedNetworkImage(
                                imageUrl: movie.posterurl,
                                fit: .cover,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: moviePrimColor,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.movie_rounded,
                                  size: 50,
                                  color: moviePrimColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const .symmetric(horizontal: 8.0),
                        child: Column(
                          spacing: 3,
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              movie.title,
                              style: TextStyle(
                                color: moviePrimText,
                                fontWeight: .w600,
                                fontSize: 15,
                              ),
                            ),
                            Row(
                              spacing: 4,
                              children: [
                                Icon(
                                  Icons.calendar_month_rounded,
                                  color: moviePrimColor,
                                ),
                                Text(
                                  MovieHelper.formatReleaseDate(
                                    movie.releaseDate,
                                  ),
                                  style: TextStyle(
                                    color: movieSecoText,
                                    fontWeight: .w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
