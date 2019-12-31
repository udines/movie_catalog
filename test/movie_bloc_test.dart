import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_bloc.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_event.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_list_bloc.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_list_event.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_list_state.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_state.dart';
import 'package:flutter_movie_catalog/models/errors/error_response.dart';
import 'package:flutter_movie_catalog/models/movies/movie.dart';
import 'package:flutter_movie_catalog/models/movies/movie_list.dart';
import 'package:flutter_movie_catalog/services/movie_db_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockMovieDbRepository extends Mock implements MovieDbRepository {}

void main() {
  final ErrorResponse error = ErrorResponse('statusMessage', 401);

  group('MovieBloc', () {
    MockMovieDbRepository repository;
    MovieBloc bloc;

    setUp(() {
      repository = MockMovieDbRepository();
      bloc = MovieBloc(repository);
    });

    group('MovieRequested', () {
      final Movie movie = Movie();
      blocTest<MovieBloc, MovieEvent, MovieState>(
        'Get movie success',
        build: () {
          when(repository.getMovie('movieId')).thenAnswer((_) => Future<Movie>.value(movie));
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const MovieRequested('movieId'))),
        expect: <MovieState>[
          NoMovieData(),
          GetMovieLoading(),
          GetMovieSuccess(movie)
        ]
      );

      blocTest<MovieBloc, MovieEvent, MovieState>(
        'Get movie error',
        build: () {
          when(repository.getMovie('movieId')).thenThrow(error);
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const MovieRequested('movieId'))),
        expect: <MovieState>[
          NoMovieData(),
          GetMovieLoading(),
          GetMovieError(error)
        ]
      );
    });
  });

  group('MovieListBloc', () {
    MockMovieDbRepository repository;
    MovieListBloc bloc;

    setUp(() {
      repository = MockMovieDbRepository();
      bloc = MovieListBloc(repository);
    });

    group('NowPlayingRequested', () {
      final MovieList movies = MovieList();
      final MovieList emptyMovies = MovieList();
      final Results movie = Results();
      movies.results = <Results>[movie];
      emptyMovies.results = <Results>[];
      const int page = 1;

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get now playing movies success',
        build: () {
          when(repository.getNowPlayingMovies(page)).thenAnswer(
            (_) => Future<MovieList>.value(movies)
          );
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const NowPlayingRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          GetMoviesSuccess(movies)
        ]
      );

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get now playing movies empty',
        build: () {
          when(repository.getNowPlayingMovies(page)).thenAnswer(
            (_) => Future<MovieList>.value(emptyMovies)
          );
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const NowPlayingRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          MovieNotFound()
        ]
      );

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get now playing movies error',
        build: () {
          when(repository.getNowPlayingMovies(page)).thenThrow(error);
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const NowPlayingRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          GetMoviesError(error)
        ]
      );
    });

    group('PopularRequested', () {
      final MovieList movies = MovieList();
      final MovieList emptyMovies = MovieList();
      final Results movie = Results();
      movies.results = <Results>[movie];
      emptyMovies.results = <Results>[];
      const int page = 1;

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get popular movies success',
        build: () {
          when(repository.getPopularMovies(page)).thenAnswer(
            (_) => Future<MovieList>.value(movies)
          );
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const PopularRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          GetMoviesSuccess(movies)
        ]
      );

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get popular movies empty',
        build: () {
          when(repository.getPopularMovies(page)).thenAnswer(
            (_) => Future<MovieList>.value(emptyMovies)
          );
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const PopularRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          MovieNotFound()
        ]
      );

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get popular movies error',
        build: () {
          when(repository.getPopularMovies(page)).thenThrow(error);
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const PopularRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          GetMoviesError(error)
        ]
      );
    });

    group('TopRatedRequested', () {
      final MovieList movies = MovieList();
      final MovieList emptyMovies = MovieList();
      final Results movie = Results();
      movies.results = <Results>[movie];
      emptyMovies.results = <Results>[];
      const int page = 1;

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get top rated movies success',
        build: () {
          when(repository.getTopRatedMovies(page)).thenAnswer(
            (_) => Future<MovieList>.value(movies)
          );
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const TopRatedRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          GetMoviesSuccess(movies)
        ]
      );

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get top rated movies empty',
        build: () {
          when(repository.getTopRatedMovies(page)).thenAnswer(
            (_) => Future<MovieList>.value(emptyMovies)
          );
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const TopRatedRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          MovieNotFound()
        ]
      );

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get top rated movies error',
        build: () {
          when(repository.getTopRatedMovies(page)).thenThrow(error);
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const TopRatedRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          GetMoviesError(error)
        ]
      );
    });

    group('UpcomingRequested', () {
      final MovieList movies = MovieList();
      final MovieList emptyMovies = MovieList();
      final Results movie = Results();
      movies.results = <Results>[movie];
      emptyMovies.results = <Results>[];
      const int page = 1;

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get upcoming movies success',
        build: () {
          when(repository.getUpcomingMovies(page)).thenAnswer(
            (_) => Future<MovieList>.value(movies)
          );
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const UpcomingRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          GetMoviesSuccess(movies)
        ]
      );

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get upcoming movies empty',
        build: () {
          when(repository.getUpcomingMovies(page)).thenAnswer(
            (_) => Future<MovieList>.value(emptyMovies)
          );
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const UpcomingRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          MovieNotFound()
        ]
      );

      blocTest<MovieListBloc, MovieListEvent, MovieListState>(
        'Get upcoming movies error',
        build: () {
          when(repository.getUpcomingMovies(page)).thenThrow(error);
          return bloc;
        },
        act: (dynamic bloc) => Future<void>.value(bloc.add(const UpcomingRequested(page))),
        expect: <MovieListState>[
          NoMovies(),
          GetMoviesLoading(),
          GetMoviesError(error)
        ]
      );
    });
  });
}