import 'package:flutter_movie_catalog/models/authentication/guest_session.dart';
import 'package:flutter_movie_catalog/models/authentication/request_token.dart';
import 'package:flutter_movie_catalog/models/authentication/session.dart';
import 'package:flutter_movie_catalog/models/movies/movie.dart';
import 'package:flutter_movie_catalog/models/movies/movie_list.dart';
import 'package:flutter_movie_catalog/services/movie_db_cache.dart';
import 'package:flutter_movie_catalog/services/movie_db_client.dart';

class MovieDbRepository {
  MovieDbRepository(this.client, this.cache);

  final MovieDbClient client;
  final MovieDbCache cache;

  Future<GuestSession> createGuestSession() async {
    final GuestSession result = await client.createGuestSession();
    return result;
  }

  Future<RequestToken> createRequestToken() async {
    final RequestToken result = await client.createRequestToken();
    return result;
  }

  Future<RequestToken> validateToken(String username, String password, String requestToken) async {
    final RequestToken result = await client.validateToken(username, password, requestToken);
    return result;
  }

  Future<Session> createSession(String validatedToken) async {
    final Session result = await client.createSession(validatedToken);
    return result;
  }

  Future<MovieList> getNowPlayingMovies(int page) async {
    if (cache.nowPlayingExists(page)) {
      return cache.getNowPlaying(page);
    } else {
      final MovieList result = await client.getNowPlayingMovies(page);
      cache.setNowPlaying(page, result);
      return result;
    }
  }

  Future<MovieList> getPopularMovies(int page) async {
    if (cache.popularExists(page)) {
      return cache.getPopular(page);
    } else {
      final MovieList result = await client.getPopularMovies(page);
      cache.setPopular(page, result);
      return result;
    }
  }

  Future<MovieList> getTopRatedMovies(int page) async {
    if (cache.topRatedExists(page)) {
      return cache.getTopRated(page);
    } else {
      final MovieList result = await client.getTopRatedMovies(page);
      cache.setTopRated(page, result);
      return result;
    }
  }

  Future<MovieList> getUpcomingMovies(int page) async {
    if (cache.upcomingExists(page)) {
      return cache.getUpcoming(page);
    } else {
      final MovieList result = await client.getUpcomingMovies(page);
      cache.setUpcoming(page, result);
      return result;
    }
  }

  Future<Movie> getMovie(int movieId) async {
    if (cache.movieExists(movieId)) {
      return cache.getMovie(movieId);
    } else {
      final Movie result = await client.getMovie(movieId);
      cache.setMovie(result);
      return result;
    }
  }
}