import 'package:flutter_movie_catalog/models/movies/movie.dart';
import 'package:flutter_movie_catalog/models/movies/movie_list.dart';

class MovieDbCache {
  final Map<int, MovieList> nowPlayingCache = <int, MovieList>{};
  final Map<int, MovieList> popularCache = <int, MovieList>{};
  final Map<int, MovieList> topRatedCache = <int, MovieList>{};
  final Map<int, MovieList> upcomingCache = <int, MovieList>{};
  final Map<int, Movie> movieCache = <int, Movie>{};

  MovieList getNowPlaying(int page) => nowPlayingCache[page];
  MovieList getPopular(int page) => popularCache[page];
  MovieList getTopRated(int page) => topRatedCache[page];
  MovieList getUpcoming(int page) => upcomingCache[page];
  Movie getMovie(int movieId) => movieCache[movieId];

  void setNowPlaying(int page, MovieList movies) => nowPlayingCache[page] = movies;
  void setPopular(int page, MovieList movies) => popularCache[page] = movies;
  void setTopRated(int page, MovieList movies) => topRatedCache[page] = movies;
  void setUpcoming(int page, MovieList movies) => upcomingCache[page] = movies;
  void setMovie(Movie movie) => movieCache[movie.id] = movie;

  bool nowPlayingExists(int page) => nowPlayingCache.containsKey(page);
  bool popularExists(int page) => popularCache.containsKey(page);
  bool topRatedExists(int page) => topRatedCache.containsKey(page);
  bool upcomingExists(int page) => upcomingCache.containsKey(page);
  bool movieExists(int movieId) => movieCache.containsKey(movieId);
}