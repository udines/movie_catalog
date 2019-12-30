import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class GuestSessionRequested extends AuthenticationEvent {
  const GuestSessionRequested();

  @override
  List<Object> get props => <Object>[];
}

class LoginRequested extends AuthenticationEvent {
  const LoginRequested(this.username, this.password);

  final String username;
  final String password;

  @override
  List<Object> get props => <Object>[username, password];
}