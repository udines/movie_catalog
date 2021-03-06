import 'dart:convert';

import 'package:flutter_movie_catalog/models/authentication/guest_session.dart';
import 'package:flutter_movie_catalog/models/authentication/request_token.dart';
import 'package:flutter_movie_catalog/models/authentication/session.dart';
import 'package:flutter_movie_catalog/models/authentication/validate_token_body.dart';
import 'package:flutter_movie_catalog/models/errors/error_response.dart';
import 'package:flutter_movie_catalog/models/movies/movie.dart';
import 'package:flutter_movie_catalog/models/movies/movie_list.dart';
import 'package:http/http.dart' as http;

class MovieDbClient {
  MovieDbClient({
    http.Client httpClient,
    this.baseUrl = 'https://api.themoviedb.org/3'
  }) : httpClient = httpClient?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  String queryMap(Map<String, String> map) {
    /// convert query map into string query
    String query = '?';
    map.forEach((String key, String value) => query = query + key + '=' + value + '&');
    final int lastIndex = query.length - 1;
    return query.substring(0, lastIndex);
  }

  Map<String, String> newQuery() {
    return <String, String>{'api_key':'f6cd08f3369460bc00695cfeda1f1a28'};
  }

  String createUrl(String endpoint, Map<String, String> map) {
    //create url based on base url, endpoint, and query
    final String flatten = queryMap(map);
    return '$baseUrl$endpoint$flatten';
  }

  Future<GuestSession> createGuestSession() async {
    const String endpoint = '/authentication/guest_session/new';
    final String url = createUrl(endpoint, newQuery());

    final http.Response response = await httpClient.get(Uri.parse(url));
    final Map<String, dynamic> results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return GuestSession.fromJson(results);
    } else {
      throw ErrorResponse.fromJson(results);
    }
  }

  Future<RequestToken> createRequestToken() async {
    const String endpoint = '/authentication/token/new';
    final String url = createUrl(endpoint, newQuery());

    final http.Response response = await httpClient.get(Uri.parse(url));
    final Map<String, dynamic> results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return RequestToken.fromJson(results);
    } else {
      throw ErrorResponse.fromJson(results);
    }
  }

  Future<RequestToken> validateToken(String username, String password,String requestToken) async {
    const String endpoint = '/authentication/token/validate_with_login';
    final String url = createUrl(endpoint, newQuery());
    final ValidateTokenBody body = ValidateTokenBody(username, password, requestToken);

    final http.Response response = await httpClient.post(Uri.parse(url), body: body.toJson());
    final Map<String, dynamic> results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return RequestToken.fromJson(results);
    } else {
      throw ErrorResponse.fromJson(results);
    }
  }

  Future<Session> createSession(String validatedToken) async {
    const String endpoint = '/authentication/session/new';
    final String url = createUrl(endpoint, newQuery());
    final String body = json.encode(<String, String>{'request_token': validatedToken});

    final http.Response response = await httpClient.post(Uri.parse(url), body: body);
    final Map<String, dynamic> results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return Session.fromJson(results);
    } else {
      throw ErrorResponse.fromJson(results);
    }
  }

  Future<MovieList> getNowPlayingMovies(int page) async {
    const String endpoint = '/movie/now_playing';
    final Map<String, String> query = newQuery();
    query['page'] = page.toString();
    final String url = createUrl(endpoint, query);

    final http.Response response = await httpClient.get(url);
    final Map<String, dynamic> results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return MovieList.fromJson(results);
    } else {
      throw ErrorResponse.fromJson(results);
    }
  }

  Future<MovieList> getPopularMovies(int page) async {
    const String endpoint = '/movie/popular';
    final Map<String, String> query = newQuery();
    query['page'] = page.toString();
    final String url = createUrl(endpoint, query);

    final http.Response response = await httpClient.get(url);
    final Map<String, dynamic> results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return MovieList.fromJson(results);
    } else {
      throw ErrorResponse.fromJson(results);
    }
  }

  Future<MovieList> getTopRatedMovies(int page) async {
    const String endpoint = '/movie/top_rated';
    final Map<String, String> query = newQuery();
    query['page'] = page.toString();
    final String url = createUrl(endpoint, query);

    final http.Response response = await httpClient.get(url);
    final Map<String, dynamic> results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return MovieList.fromJson(results);
    } else {
      throw ErrorResponse.fromJson(results);
    }
  }

  Future<MovieList> getUpcomingMovies(int page) async {
    const String endpoint = '/movie/upcoming';
    final Map<String, String> query = newQuery();
    query['page'] = page.toString();
    final String url = createUrl(endpoint, query);

    final http.Response response = await httpClient.get(url);
    final Map<String, dynamic> results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return MovieList.fromJson(results);
    } else {
      throw ErrorResponse.fromJson(results);
    }
  }

  Future<Movie> getMovie(int movieId) async {
    final String endpoint = '/movie/' + movieId.toString();
    final String url = createUrl(endpoint, newQuery());

    final http.Response response = await httpClient.get(url);
    final Map<String, dynamic> results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return Movie.fromJson(results);
    } else {
      throw ErrorResponse.fromJson(results);
    }
  }
}