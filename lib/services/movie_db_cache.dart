import 'package:flutter_movie_catalog/models/movies/movie.dart';

class MovieDbCache {
  final Map<int, Movie> movieCache = <int, Movie>{};

  Movie getMovie(int movieId) => movieCache[movieId];

  void setMovie(Movie movie) => movieCache[movie.id] = movie;

  bool movieExists(int movieId) => movieCache.containsKey(movieId);
}