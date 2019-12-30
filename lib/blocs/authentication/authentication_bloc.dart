import 'package:bloc/bloc.dart';
import 'package:flutter_movie_catalog/blocs/authentication/authentication_event.dart';
import 'package:flutter_movie_catalog/blocs/authentication/authentication_state.dart';
import 'package:flutter_movie_catalog/models/authentication/guest_session.dart';
import 'package:flutter_movie_catalog/models/authentication/request_token.dart';
import 'package:flutter_movie_catalog/models/authentication/session.dart';
import 'package:flutter_movie_catalog/models/errors/error_response.dart';
import 'package:flutter_movie_catalog/services/movie_db_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.repository);

  final MovieDbRepository repository;

  @override
  AuthenticationState get initialState => NotAuthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    yield AuthenticationLoading();
    if (event is GuestSessionRequested) {
      yield* _mapGuestSessionRequestedToState(event);
    } else if (event is LoginRequested) {
      yield* _mapLoginRequestedToState(event);
    }
  }

  Stream<AuthenticationState> _mapGuestSessionRequestedToState(GuestSessionRequested event) async* {
    try {
      final GuestSession guestSession = await repository.createGuestSession();
      if (guestSession.success) {
        yield GuestAuthenticationSuccess(guestSession);
      } else {
        yield NotAuthenticated();
      }
    } catch (error) {
      yield error is ErrorResponse
        ? AuthenticationFailed(error)
        : AuthenticationFailed(ErrorResponse('Something went wrong', 0));
    }
  }

  Stream<AuthenticationState> _mapLoginRequestedToState(LoginRequested event) async* {
    final String username = event.username;
    final String password = event.password;
    try {
      final RequestToken requestToken = await repository.createRequestToken();
      final RequestToken validatedToken = 
        await repository.validateToken(username, password, requestToken.requestToken);
      final Session session = await repository.createSession(validatedToken.requestToken);
      if (session.success) {
        yield AuthenticationSuccess(session);
      } else {
        yield NotAuthenticated();
      }
    } catch (error) {
      yield error is ErrorResponse
        ? AuthenticationFailed(error)
        : AuthenticationFailed(ErrorResponse('Something went wrong', 0));
    }
  }
}