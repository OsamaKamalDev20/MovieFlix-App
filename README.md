# 🎬 MovieFlix
A Flutter movie browsing app built with Provider state management, MVVM architecture, and REST API integration. Browse trending movies, 
explore the full catalog, and view detailed information for each title

## ✨ Features
##### Home screen with an auto-playing banner carousel and a "Trending Now" grid (top 10 movies)
##### See All page showing the complete movie catalog (95 movies) in a scrollable grid
##### Movie detail page with:
##### Poster with Hero animation
##### IMDb rating and user rating (5-star display, calculated from the ratings array)
##### Formatted duration (PT100M → 1h 40min) and release date (2018-02-28 → 28 Feb 2018)
##### Genres, storyline, and cast with initials avatars
##### Loading, empty, and error states handled in the UI
##### Safe JSON parsing: null, empty, and missing fields fall back to default values instead of crashing
##### Cached network images for smooth scrolling

## 🏗️ Architecture (MVVM)
| Layer | Responsibility |
|-----------|-----------|
| Model | Data classes and JSON parsing (MovieModel, MoviesList) |
| Service | Makes the HTTP request and decodes the response |
| Repository | Single source of data for the ViewModel |
| ViewModel | Holds UI state (movies, allMovies, isLoading, errorMessage) and notifies listeners |
| View | Widgets that listen to the ViewModel using Consumer |

## 🛠️ Tech Stack
##### Flutter and Dart
##### provider: state management
##### http: REST API calls
##### cached_network_image: image loading and caching
##### carousel_slider: home banner
##### flutter_rating_bar: star ratings
##### intl: date formatting

## 🎬 Demo of Project
https://github.com/user-attachments/assets/bef019c7-8f09-43b6-ade9-48ecf254504a




