import 'package:bloc/bloc.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_event.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_state.dart';
import 'package:flutter_movie_catalog/models/errors/error_response.dart';
import 'package:flutter_movie_catalog/models/movies/movie.dart';
import 'package:flutter_movie_catalog/services/movie_db_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc(this.repository);

  final MovieDbRepository repository;

  @override
  MovieState get initialState => NoMovieData();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieRequested) {
      yield* _mapMovieRequestedToState(event);
    }
  }

  Stream<MovieState> _mapMovieRequestedToState(MovieRequested event) async* {
    final String movieId = event.movieId;
    try {
      final Movie movie = await repository.getMovie(movieId);
      if (movie != null) {
        yield GetMovieSuccess(movie);
      } else {
        yield NoMovieData();
      }
    } catch (error) {
      yield error is ErrorResponse
        ? GetMovieError(error)
        : GetMovieError(ErrorResponse('Something went wrong', 0));
    }
  }
}