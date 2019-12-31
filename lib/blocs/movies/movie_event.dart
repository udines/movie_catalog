import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class MovieRequested extends MovieEvent {
  const MovieRequested(this.movieId);

  final String movieId;

  @override
  List<Object> get props => <Object>[];
}