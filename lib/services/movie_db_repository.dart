import 'package:flutter_movie_catalog/models/authentication/guest_session.dart';
import 'package:flutter_movie_catalog/models/authentication/request_token.dart';
import 'package:flutter_movie_catalog/models/authentication/session.dart';
import 'package:flutter_movie_catalog/models/movies/movie_list.dart';
import 'package:flutter_movie_catalog/services/movie_db_client.dart';

class MovieDbRepository {
  MovieDbRepository(this.client);

  final MovieDbClient client;

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
    final MovieList result = await client.getNowPlayingMovies(page);
    return result;
  }

  Future<MovieList> getPopularMovies(int page) async {
    final MovieList result = await client.getPopularMovies(page);
    return result;
  }

  Future<MovieList> getTopRatedMovies(int page) async {
    final MovieList result = await client.getTopRatedMovies(page);
    return result;
  }

  Future<MovieList> getUpcomingMovies(int page) async {
    final MovieList result = await client.getUpcomingMovies(page);
    return result;
  }
}