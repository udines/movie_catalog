import 'package:flutter_movie_catalog/models/authentication/guest_session.dart';
import 'package:flutter_movie_catalog/models/authentication/request_token.dart';
import 'package:flutter_movie_catalog/models/authentication/session.dart';
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
}