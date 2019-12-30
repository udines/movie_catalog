import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_movie_catalog/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_movie_catalog/blocs/authentication/authentication_event.dart';
import 'package:flutter_movie_catalog/blocs/authentication/authentication_state.dart';
import 'package:flutter_movie_catalog/models/authentication/guest_session.dart';
import 'package:flutter_movie_catalog/models/authentication/request_token.dart';
import 'package:flutter_movie_catalog/models/authentication/session.dart';
import 'package:flutter_movie_catalog/models/errors/error_response.dart';
import 'package:flutter_movie_catalog/services/movie_db_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockMovieDbRepository extends Mock implements MovieDbRepository {}

void main() {
  group('AuthenticationBloc', () {
    MovieDbRepository repository;
    AuthenticationBloc authenticationBloc;

    setUp(() {
      repository = MockMovieDbRepository();
      authenticationBloc = AuthenticationBloc(repository);
    });

    group('GuestSessionRequested', () {
      final GuestSession guestSessionSuccess = GuestSession(true, 'guestSessionId', 'expiresAt');
      final GuestSession guestSessionFail = GuestSession(false, '', '');
      final ErrorResponse guestSessionError = ErrorResponse('statusMessage', 401);
      blocTest<AuthenticationBloc, AuthenticationEvent, AuthenticationState>(
        'Guest session request success', 
        build: () {
          when(repository.createGuestSession()).thenAnswer(
            (_) => Future<GuestSession>.value(guestSessionSuccess)
          );
          return authenticationBloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const GuestSessionRequested())),
        expect: <AuthenticationState>[
          NotAuthenticated(),
          AuthenticationLoading(),
          GuestAuthenticationSuccess(guestSessionSuccess)
        ]
      );

      blocTest<AuthenticationBloc, AuthenticationEvent, AuthenticationState>(
        'Guest session request failed', 
        build: () {
          when(repository.createGuestSession()).thenAnswer(
            (_) => Future<GuestSession>.value(guestSessionFail)
          );
          return authenticationBloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const GuestSessionRequested())),
        expect: <AuthenticationState>[
          NotAuthenticated(),
          AuthenticationLoading(),
          NotAuthenticated()
        ]
      );

      blocTest<AuthenticationBloc, AuthenticationEvent, AuthenticationState>(
        'Guest session request error', 
        build: () {
          when(repository.createGuestSession()).thenThrow(guestSessionError);
          return authenticationBloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const GuestSessionRequested())),
        expect: <AuthenticationState>[
          NotAuthenticated(),
          AuthenticationLoading(),
          AuthenticationFailed(guestSessionError)
        ]
      );
    });

    group('LoginRequested', () {
      final RequestToken requestTokenSuccess = RequestToken(true, 'expiresAt', 'requestToken');
      final Session sessionSuccess = Session(true, 'sessionId');
      final Session sessionFail = Session(false, '');
      final ErrorResponse error = ErrorResponse('statusMessage', 401);
      const LoginRequested event = LoginRequested('username', 'password');

      blocTest<AuthenticationBloc, AuthenticationEvent, AuthenticationState>(
        'Create session success',
        build: () {
          when(repository.createRequestToken()).thenAnswer(
            (_) => Future<RequestToken>.value(requestTokenSuccess)
          );
          when(repository.validateToken(event.username, event.password, requestTokenSuccess.requestToken))
            .thenAnswer((_) => Future<RequestToken>.value(requestTokenSuccess));
          when(repository.createSession(requestTokenSuccess.requestToken)).thenAnswer(
            (_) => Future<Session>.value(sessionSuccess)
          );
          return authenticationBloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(event)),
        expect: <AuthenticationState>[
          NotAuthenticated(),
          AuthenticationLoading(),
          AuthenticationSuccess(sessionSuccess)
        ]
      );

      blocTest<AuthenticationBloc, AuthenticationEvent, AuthenticationState>(
        'Create session createRequestToken throws error',
        build: () {
          when(repository.createRequestToken()).thenThrow(error);
          when(repository.validateToken(event.username, event.password, requestTokenSuccess.requestToken))
            .thenAnswer((_) => Future<RequestToken>.value(requestTokenSuccess));
          when(repository.createSession(requestTokenSuccess.requestToken)).thenAnswer(
            (_) => Future<Session>.value(sessionSuccess)
          );
          return authenticationBloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(event)),
        expect: <AuthenticationState>[
          NotAuthenticated(),
          AuthenticationLoading(),
          AuthenticationFailed(error)
        ]
      );

      blocTest<AuthenticationBloc, AuthenticationEvent, AuthenticationState>(
        'Create session validateToken throws error',
        build: () {
          when(repository.createRequestToken()).thenAnswer(
            (_) => Future<RequestToken>.value(requestTokenSuccess)
          );
          when(repository.validateToken(event.username, event.password, requestTokenSuccess.requestToken))
            .thenThrow(error);
          when(repository.createSession(requestTokenSuccess.requestToken)).thenAnswer(
            (_) => Future<Session>.value(sessionSuccess)
          );
          return authenticationBloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(event)),
        expect: <AuthenticationState>[
          NotAuthenticated(),
          AuthenticationLoading(),
          AuthenticationFailed(error)
        ]
      );

      blocTest<AuthenticationBloc, AuthenticationEvent, AuthenticationState>(
        'Create session createSession throws error',
        build: () {
          when(repository.createRequestToken()).thenAnswer(
            (_) => Future<RequestToken>.value(requestTokenSuccess)
          );
          when(repository.validateToken(event.username, event.password, requestTokenSuccess.requestToken))
            .thenAnswer((_) => Future<RequestToken>.value(requestTokenSuccess));
          when(repository.createSession(requestTokenSuccess.requestToken)).thenThrow(error);
          return authenticationBloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(event)),
        expect: <AuthenticationState>[
          NotAuthenticated(),
          AuthenticationLoading(),
          AuthenticationFailed(error)
        ]
      );

      blocTest<AuthenticationBloc, AuthenticationEvent, AuthenticationState>(
        'Create session failed',
        build: () {
          when(repository.createRequestToken()).thenAnswer(
            (_) => Future<RequestToken>.value(requestTokenSuccess)
          );
          when(repository.validateToken(event.username, event.password, requestTokenSuccess.requestToken))
            .thenAnswer((_) => Future<RequestToken>.value(requestTokenSuccess));
          when(repository.createSession(requestTokenSuccess.requestToken)).thenAnswer(
            (_) => Future<Session>.value(sessionFail)
          );
          return authenticationBloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(event)),
        expect: <AuthenticationState>[
          NotAuthenticated(),
          AuthenticationLoading(),
          NotAuthenticated()
        ]
      );
    });
  });
}
