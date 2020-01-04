import 'package:flutter/material.dart';
import 'package:flutter_movie_catalog/screens/movies_screen.dart';
import 'package:flutter_movie_catalog/services/movie_db_cache.dart';
import 'package:flutter_movie_catalog/services/movie_db_client.dart';
import 'package:flutter_movie_catalog/services/movie_db_repository.dart';
import 'package:injector/injector.dart';

void main() {
  final Injector injector = Injector.appInstance;

  injector.registerSingleton<MovieDbClient>((_) => MovieDbClient());
  injector.registerSingleton<MovieDbCache>((_) => MovieDbCache());
  injector.registerSingleton<MovieDbRepository>((Injector injector) {
    final MovieDbClient client = injector.getDependency<MovieDbClient>();
    final MovieDbCache cache = injector.getDependency<MovieDbCache>();
    return MovieDbRepository(client, cache);
  });

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MoviesScreen()
    );
  }
}