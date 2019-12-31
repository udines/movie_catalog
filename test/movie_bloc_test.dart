import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_bloc.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_event.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_state.dart';
import 'package:flutter_movie_catalog/models/errors/error_response.dart';
import 'package:flutter_movie_catalog/models/movies/movie.dart';
import 'package:flutter_movie_catalog/services/movie_db_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockMovieDbRepository extends Mock implements MovieDbRepository {}

void main() {
  group('MovieBloc', () {
    MockMovieDbRepository repository;
    MovieBloc bloc;

    setUp(() {
      repository = MockMovieDbRepository();
      bloc = MovieBloc(repository);
    });

    group('MovieRequested', () {
      final Movie movie = Movie();
      final ErrorResponse error = ErrorResponse('statusMessage', 401);
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
}