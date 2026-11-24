// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:firebase_project/Movie%20App/view/movie_onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../themes/movies_colors.dart';

class MovieSplashScreen extends StatefulWidget {
  const MovieSplashScreen({super.key});

  @override
  State<MovieSplashScreen> createState() => _MovieSplashScreenState();
}

class _MovieSplashScreenState extends State<MovieSplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MovieOnboardingView()),
      );
    });
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
    return Scaffold(
      backgroundColor: movieScafColor,
      body: Container(
        width: .infinity,
        height: .infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: .topCenter,
            end: .bottomCenter,
            colors: movieGradient,
            stops: [0.0, 0.35, 0.70, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Background image with overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(
                      "assets/images/movie/splash_screen.jpg",
                    ),
                    fit: .cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7),
                      .darken,
                    ),
                  ),
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: Padding(
                padding: const .symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/movie/logo.png",
                      // width: 110,
                      // height: 110,
                      fit: .contain,
                    ),

                    // Main heading
                    const SizedBox(height: 15),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 40, fontWeight: .bold),
                        children: [
                          TextSpan(
                            text: "Movie",
                            style: TextStyle(color: moviePrimText),
                          ),
                          TextSpan(
                            text: "Flix",
                            style: TextStyle(color: movieSecColor),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),
                    Text(
                      "YOUR NEXT FAVORITE MOVIE\nIS JUST A TAP AWAY",
                      textAlign: .center,
                      style: TextStyle(
                        color: movieAncText,
                        height: 1.4,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 60),
                    SpinKitThreeBounce(color: movieSecColor, size: 30.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
