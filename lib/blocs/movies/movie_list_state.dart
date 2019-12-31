import 'package:equatable/equatable.dart';
import 'package:flutter_movie_catalog/models/errors/error_response.dart';
import 'package:flutter_movie_catalog/models/movies/movie_list.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => <Object>[];
}

class MovieNotFound extends MovieListState {}
class NoMovieData extends MovieListState {}
class GetMoviesLoading extends MovieListState {}

class GetMoviesSuccess extends MovieListState {
  const GetMoviesSuccess(this.movies);

  final MovieList movies;

  @override
  List<Object> get props => <MovieList>[movies];
}

class GetMoviesError extends MovieListState {
  const GetMoviesError(this.error);

  final ErrorResponse error;

  @override
  List<Object> get props => <ErrorResponse>[error];
}
