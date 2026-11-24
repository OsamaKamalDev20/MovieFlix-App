import 'package:animate_do/animate_do.dart';
import 'package:firebase_project/Movie%20App/json/movie_onboarding_data.dart';
import 'package:firebase_project/Movie%20App/provider/movie_onboarding_screen_provider.dart';
import 'package:firebase_project/Movie%20App/themes/movies_colors.dart';
import 'package:firebase_project/Movie%20App/view/movie_home_view.dart';
import 'package:firebase_project/Movie%20App/widgets/movie_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MovieOnboardingView extends StatefulWidget {
  const MovieOnboardingView({super.key});

  @override
  State<MovieOnboardingView> createState() => _MovieOnboardingViewState();
}

class _MovieOnboardingViewState extends State<MovieOnboardingView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    context.read<MovieOnboardingScreenProvider>().initializeAnimations(this);
  }

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Consumer<MovieOnboardingScreenProvider>(
      builder: ((context, provider, _) {
        final isLastPage = provider.currentPage == movie.length - 1;
        return Scaffold(
          backgroundColor: movieScafColor,
          body: SafeArea(
            child: Column(
              children: [
                // 🔹 Skip Button Row
                Padding(
                  padding: const .only(right: 16),
                  child: Align(
                    alignment: .topRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MovieHomeView()),
                        );
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: .w500,
                          color: movieSecColor,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: provider.movieController,
                    itemCount: movie.length,
                    onPageChanged: provider.onPageChanged,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const .symmetric(horizontal: 24),
                        child: FadeTransition(
                          opacity: provider.fadeAnimation,
                          child: SlideTransition(
                            position: provider.slideAnimation,
                            child: Column(
                              spacing: 12,
                              mainAxisAlignment: .center,
                              children: [
                                // Animated image container
                                Container(
                                  width: .infinity,
                                  height: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: .circular(6),
                                    border: .all(color: movieCard, width: 1.5),
                                  ),
                                  child: ScaleTransition(
                                    scale: provider.scaleAnimation,
                                    child: Hero(
                                      tag: "movies_${movie[index].image}",
                                      child: ClipRRect(
                                        borderRadius: .circular(10),
                                        child: Stack(
                                          fit: .expand,
                                          children: [
                                            Image.asset(
                                              movie[index].image,
                                              fit: .cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Title with animated container
                                FadeInLeft(
                                  delay: const Duration(milliseconds: 1200),
                                  child: Text(
                                    movie[index].title,
                                    textAlign: .center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: .bold,
                                      color: moviePrimText,
                                    ),
                                  ),
                                ),

                                // Description with animated container
                                FadeInUp(
                                  delay: const Duration(milliseconds: 1200),
                                  child: Text(
                                    movie[index].description,
                                    textAlign: .center,
                                    style: TextStyle(
                                      fontSize: 15.5,
                                      color: movieSecoText,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Page indicator
                const SizedBox(height: 15),
                FadeInLeft(
                  delay: const Duration(milliseconds: 1000),
                  child: SmoothPageIndicator(
                    controller: provider.movieController,
                    count: movie.length,
                    effect: CustomizableEffect(
                      dotDecoration: DotDecoration(
                        width: 15,
                        height: 15,
                        color: moviePrimColor.withValues(alpha: .3),
                        borderRadius: .circular(50),
                      ),
                      activeDotDecoration: DotDecoration(
                        width: 40,
                        height: 8,
                        color: moviePrimColor,
                        borderRadius: .circular(50),
                      ),
                    ),
                  ),
                ),

                // Gradient Button
                const SizedBox(height: 40),
                FadeInLeft(
                  delay: const Duration(milliseconds: 1000),
                  child: MovieGradientButton(
                    text: isLastPage ? "Let's Watch" : "Next",
                    onPressed: () {
                      HapticFeedback.lightImpact();

                      if (isLastPage) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MovieHomeView()),
                        );
                      } else {
                        provider.nextPage(movie.length);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
