import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_project/Movie%20App/provider/movie_banner_provider.dart';
import 'package:firebase_project/Movie%20App/themes/movies_colors.dart';
import 'package:firebase_project/Movie%20App/view/movie_lists_view.dart';
import 'package:firebase_project/Movie%20App/viewmodel/movie_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie_detail_view.dart';

class MovieHomeView extends StatefulWidget {
  const MovieHomeView({super.key});

  @override
  State<MovieHomeView> createState() => _MovieHomeViewState();
}

class _MovieHomeViewState extends State<MovieHomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieViewmodel>().fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieBannerProvider = context.watch<MovieBannerProvider>();
    return Scaffold(
      backgroundColor: movieScafColor,
      body: SafeArea(
        child: Padding(
          padding: const .all(15),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              // Movie Appbar
              movieAppbar(),
              // Movie Scrollable Banner
              const SizedBox(height: 24),
              movieBanner(movieBannerProvider),
              // Trending Movies
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "Trending Now",
                    style: TextStyle(
                      fontSize: 20,
                      color: moviePrimText,
                      fontWeight: .w600,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TrendingMovieListsView(),
                        ),
                      );
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 14,
                        color: moviePrimColor,
                        fontWeight: .w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              movieLists(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded movieLists() {
    return Expanded(
      child: Consumer<MovieViewmodel>(
        builder: ((context, viewModel, child) {
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
          if (viewModel.movies.isEmpty) {
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
          // Successs Response
          return GridView.builder(
            padding: EdgeInsets.only(bottom: 15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.8,
            ),
            itemCount: viewModel.movies.length,
            itemBuilder: (context, index) {
              final movie = viewModel.movies[index];
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
                  shadowColor: moviePrimColor.withValues(alpha: .3),
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
                              borderRadius: .vertical(top: .circular(10)),
                              child: CachedNetworkImage(
                                imageUrl: movie.posterurl,
                                fit: BoxFit.cover,
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
                            Text(
                              movie.year,
                              style: TextStyle(
                                color: movieSecoText,
                                fontWeight: .w500,
                                fontSize: 12,
                              ),
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
        }),
      ),
    );
  }

  Column movieBanner(MovieBannerProvider movieBannerProvider) {
    return Column(
      spacing: 20,
      children: [
        CarouselSlider.builder(
          itemCount: movieBannerProvider.movieBanner.length,
          options: CarouselOptions(
            height: 200,
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
            onPageChanged: (index, reason) {
              movieBannerProvider.changeIndex(index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: .circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  Image.asset(
                    movieBannerProvider.movieBanner[index],
                    fit: .cover,
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: .centerLeft,
                        end: .centerRight,
                        colors: [
                          Colors.black.withValues(alpha: 0.90),
                          Colors.black.withValues(alpha: 0.55),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Bottom Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: .bottomCenter,
                        end: .topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.65),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Movie Content
                  Positioned(
                    left: 18,
                    right: 12,
                    bottom: 18,
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        // Movie Tag
                        Container(
                          padding: const .symmetric(horizontal: 9, vertical: 5),
                          decoration: BoxDecoration(
                            color: moviePrimColor,
                            borderRadius: .circular(5),
                          ),
                          child: const Text(
                            'FEATURED MOVIE',
                            style: TextStyle(
                              color: moviePrimText,
                              fontSize: 9.5,
                              fontWeight: .bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Movie Title
                        const Text(
                          'Game Night',
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: TextStyle(
                            color: moviePrimText,
                            fontSize: 25,
                            fontWeight: .bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Movie Details
                        Text(
                          '2018  •  Action  •  Comedy  •  Crime',
                          style: TextStyle(color: movieSecoText, fontSize: 12),
                        ),
                        const SizedBox(height: 12),

                        // Trailer Button
                        SizedBox(
                          height: 38,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: moviePrimColor,
                              foregroundColor: moviePrimText,
                              elevation: 0,
                              padding: const .symmetric(horizontal: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: .circular(8),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              size: 20,
                            ),
                            label: const Text(
                              'Play Trailer',
                              style: TextStyle(fontSize: 13, fontWeight: .w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            movieBannerProvider.movieBanner.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: movieBannerProvider.currentIndex == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: movieBannerProvider.currentIndex == index
                    ? moviePrimColor
                    : moviePrimColor.withValues(alpha: .18),
                borderRadius: .circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row movieAppbar() {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 26, fontWeight: .bold),
            children: [
              TextSpan(
                text: "Movie",
                style: TextStyle(color: moviePrimText),
              ),
              TextSpan(
                text: "Flix",
                style: TextStyle(color: moviePrimColor),
              ),
            ],
          ),
        ),
        Row(
          spacing: 20,
          children: [
            Icon(CupertinoIcons.search, color: moviePrimText, size: 24),
            Container(
              decoration: BoxDecoration(
                shape: .circle,
                border: .all(width: 1.5, color: moviePrimColor),
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
