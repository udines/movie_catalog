import 'package:equatable/equatable.dart';
import 'package:flutter_movie_catalog/models/errors/error_response.dart';
import 'package:flutter_movie_catalog/models/movies/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => <Object>[];
}

class NoMovieData extends MovieState {}
class GetMovieLoading extends MovieState {}

class GetMovieSuccess extends MovieState {
  const GetMovieSuccess(this.movie);

  final Movie movie;

  @override
  List<Object> get props => <Movie>[movie];
}

class GetMovieError extends MovieState {
  const GetMovieError(this.error);

  final ErrorResponse error;

  @override
  List<Object> get props => <ErrorResponse>[error];
}