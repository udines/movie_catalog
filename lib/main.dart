import 'package:flutter/material.dart';
import 'package:flutter_movie_catalog/screens/movies_screen.dart';
import 'package:flutter_movie_catalog/services/movie_db_cache.dart';
import 'package:flutter_movie_catalog/services/movie_db_client.dart';
import 'package:flutter_movie_catalog/services/movie_db_repository.dart';

void main() {
  final MovieDbRepository _movieDbRepository = MovieDbRepository(
    MovieDbClient(),
    MovieDbCache()
  );

  runApp(App(movieDbRepository: _movieDbRepository));
}

class App extends StatelessWidget {
  const App({
    Key key, 
    @required this.movieDbRepository
  }) : super(key: key);

  final MovieDbRepository movieDbRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MoviesScreen(movieDbRepository)
    );
  }
}