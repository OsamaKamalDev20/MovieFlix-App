class MovieOnboardingData {
  String title, description, image;

  MovieOnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<MovieOnboardingData> movie = [
  MovieOnboardingData(
    title: "Discover Your Next Favorite",
    description:
        "Explore thousands of movies across action, comedy, crime, and more. Find the perfect movie for every mood.",
    image: "assets/images/movie/onboarding_1.jpg",
  ),
  MovieOnboardingData(
    title: "Stories That Keep You Hooked",
    description:
        "Dive into exciting storylines, discover talented actors, and explore the details behind every movie.",
    image: "assets/images/movie/onboarding_2.jpg",
  ),
  MovieOnboardingData(
    title: "Your Next Movie Starts Here",
    description:
        "Find your next favorite film, explore new genres, and get ready for your next cinematic adventure.",
    image: "assets/images/movie/onboarding_3.jpg",
  ),
];
