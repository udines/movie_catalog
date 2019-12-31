import 'package:bloc/bloc.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_list_event.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_list_state.dart';
import 'package:flutter_movie_catalog/models/errors/error_response.dart';
import 'package:flutter_movie_catalog/models/movies/movie_list.dart';
import 'package:flutter_movie_catalog/services/movie_db_repository.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc(this.repository);

  final MovieDbRepository repository;

  @override
  MovieListState get initialState => NoMovieData();

  @override
  Stream<MovieListState> mapEventToState(MovieListEvent event) async* {
    if (event is NowPlayingRequested) {
      yield* _mapNowPlayingEventToState(event);
    } else if (event is PopularRequested) {
      yield* _mapPopularEventToState(event);
    } else if (event is TopRatedRequested) {
      yield* _mapTopRatedEventToState(event);
    } else if (event is UpcomingRequested) {
      yield* _mapUpcomingEventToState(event);
    }
  }

  Stream<MovieListState> _mapNowPlayingEventToState(NowPlayingRequested event) async* {
    final int page = event.page;
    try {
      final MovieList movies = await repository.getNowPlayingMovies(page);
      if (movies.results.isNotEmpty) {
        yield GetMoviesSuccess(movies);
      } else {
        yield MovieNotFound();
      }
    } catch (error) {
      yield error is ErrorResponse
        ? GetMoviesError(error)
        : GetMoviesError(ErrorResponse('Something went wrong', 0));
    }
  }

  Stream<MovieListState> _mapPopularEventToState(PopularRequested event) async* {
    final int page = event.page;
    try {
      final MovieList movies = await repository.getPopularMovies(page);
      if (movies.results.isNotEmpty) {
        yield GetMoviesSuccess(movies);
      } else {
        yield MovieNotFound();
      }
    } catch (error) {
      yield error is ErrorResponse
        ? GetMoviesError(error)
        : GetMoviesError(ErrorResponse('Something went wrong', 0));
    }
  }

  Stream<MovieListState> _mapTopRatedEventToState(TopRatedRequested event) async* {
    final int page = event.page;
    try {
      final MovieList movies = await repository.getTopRatedMovies(page);
      if (movies.results.isNotEmpty) {
        yield GetMoviesSuccess(movies);
      } else {
        yield MovieNotFound();
      }
    } catch (error) {
      yield error is ErrorResponse
        ? GetMoviesError(error)
        : GetMoviesError(ErrorResponse('Something went wrong', 0));
    }
  }

  Stream<MovieListState> _mapUpcomingEventToState(UpcomingRequested event) async* {
    final int page = event.page;
    try {
      final MovieList movies = await repository.getUpcomingMovies(page);
      if (movies.results.isNotEmpty) {
        yield GetMoviesSuccess(movies);
      } else {
        yield MovieNotFound();
      }
    } catch (error) {
      yield error is ErrorResponse
        ? GetMoviesError(error)
        : GetMoviesError(ErrorResponse('Something went wrong', 0));
    }
  }
}