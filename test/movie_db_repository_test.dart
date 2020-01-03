import 'package:flutter_movie_catalog/models/movies/movie_list.dart';
import 'package:flutter_movie_catalog/services/movie_db_cache.dart';
import 'package:flutter_movie_catalog/services/movie_db_client.dart';
import 'package:flutter_movie_catalog/services/movie_db_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements MovieDbClient {}
class MockCache extends Mock implements MovieDbCache {}

void main() {
  MovieDbRepository repository;
  MockClient client;
  MockCache cache;

  setUp(() {
    client = MockClient();
    cache = MockCache();
    repository = MovieDbRepository(client, cache);
  });

  group('getNowPlayingMovies', () {
    final MovieList movies = MovieList();
    const int page = 1;

    test('get now playing movies from cache', () async {
      when(cache.nowPlayingExists(page)).thenReturn(true);
      await repository.getNowPlayingMovies(page);
      verify(cache.nowPlayingExists(page));
      verify(cache.getNowPlaying(page));
      verifyNever(client.getNowPlayingMovies(page));
      verifyNever(cache.setNowPlaying(page, movies));
    });

    test('get now playing movies from api', () async {
      when(cache.nowPlayingExists(page)).thenReturn(false);
      when(client.getNowPlayingMovies(page)).thenAnswer(
        (_) => Future<MovieList>.value(movies)
      );
      await repository.getNowPlayingMovies(page);
      verify(cache.nowPlayingExists(page));
      verifyNever(cache.getNowPlaying(page));
      verify(client.getNowPlayingMovies(page));
      verify(cache.setNowPlaying(page, movies));
    });
  });

  group('getPopularMovies', () {
    final MovieList movies = MovieList();
    const int page = 2;

    test('get popular movies from cache', () async {
      when(cache.popularExists(page)).thenReturn(true);
      await repository.getPopularMovies(page);
      verify(cache.popularExists(page));
      verify(cache.getPopular(page));
      verifyNever(client.getPopularMovies(page));
      verifyNever(cache.setPopular(page, movies));
    });

    test('get popular movies from api', () async {
      when(cache.popularExists(page)).thenReturn(false);
      when(client.getPopularMovies(page)).thenAnswer(
        (_) => Future<MovieList>.value(movies)
      );
      await repository.getPopularMovies(page);
      verify(cache.popularExists(page));
      verifyNever(cache.getPopular(page));
      verify(client.getPopularMovies(page));
      verify(cache.setPopular(page, movies));
    });
  });

  group('getTopRatedMovies', () {
    final MovieList movies = MovieList();
    const int page = 3;

    test('get top rated movies from cache', () async {
      when(cache.topRatedExists(page)).thenReturn(true);
      await repository.getTopRatedMovies(page);
      verify(cache.topRatedExists(page));
      verify(cache.getTopRated(page));
      verifyNever(client.getTopRatedMovies(page));
      verifyNever(cache.setTopRated(page, movies));
    });

    test('get top rated movies from api', () async {
      when(cache.topRatedExists(page)).thenReturn(false);
      when(client.getTopRatedMovies(page)).thenAnswer(
        (_) => Future<MovieList>.value(movies)
      );
      await repository.getTopRatedMovies(page);
      verify(cache.topRatedExists(page));
      verifyNever(cache.getTopRated(page));
      verify(client.getTopRatedMovies(page));
      verify(cache.setTopRated(page, movies));
    });
  });

  group('getUpcomingMovies', () {
    final MovieList movies = MovieList();
    const int page = 4;

    test('get upcoming movies from cache', () async {
      when(cache.upcomingExists(page)).thenReturn(true);
      await repository.getUpcomingMovies(page);
      verify(cache.upcomingExists(page));
      verify(cache.getUpcoming(page));
      verifyNever(client.getUpcomingMovies(page));
      verifyNever(cache.setUpcoming(page, movies));
    });

    test('get upcoming movies from api', () async {
      when(cache.upcomingExists(page)).thenReturn(false);
      when(client.getUpcomingMovies(page)).thenAnswer(
        (_) => Future<MovieList>.value(movies)
      );
      await repository.getUpcomingMovies(page);
      verify(cache.upcomingExists(page));
      verifyNever(cache.getUpcoming(page));
      verify(client.getUpcomingMovies(page));
      verify(cache.setUpcoming(page, movies));
    });
  });
}