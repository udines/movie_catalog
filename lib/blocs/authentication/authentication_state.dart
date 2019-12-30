import 'package:equatable/equatable.dart';
import 'package:flutter_movie_catalog/models/authentication/guest_session.dart';
import 'package:flutter_movie_catalog/models/authentication/session.dart';
import 'package:flutter_movie_catalog/models/errors/error_response.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => <Object>[];
}

class NotAuthenticated extends AuthenticationState {}
class AuthenticationLoading extends AuthenticationState {}

class AuthenticationExpired extends AuthenticationState {
  const AuthenticationExpired(this.error);

  final ErrorResponse error;

  @override
  List<Object> get props => <Object>[error];
}

class GuestAuthenticationSuccess extends AuthenticationState {
  const GuestAuthenticationSuccess(this.guestSession);

  final GuestSession guestSession;

  @override
  List<Object> get props => <Object>[guestSession];
}

class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess(this.session);

  final Session session;

  @override
  List<Object> get props => <Object>[session];
}

class AuthenticationFailed extends AuthenticationState {
  const AuthenticationFailed(this.error);

  final ErrorResponse error;

  @override
  List<Object> get props => <Object>[error];
}