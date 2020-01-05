import 'package:flutter/material.dart';
import 'package:flutter_movie_catalog/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_bloc.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_list_bloc.dart';
import 'package:flutter_movie_catalog/screens/movies_screen.dart';
import 'package:flutter_movie_catalog/services/movie_db_cache.dart';
import 'package:flutter_movie_catalog/services/movie_db_client.dart';
import 'package:flutter_movie_catalog/services/movie_db_repository.dart';
import 'package:injector/injector.dart';

void main() {
  final Injector injector = Injector.appInstance;
  _registerDependencies(injector);
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

void _registerDependencies(Injector injector) {
  injector.registerSingleton<MovieDbClient>((_) => MovieDbClient());
  injector.registerSingleton<MovieDbCache>((_) => MovieDbCache());
  injector.registerSingleton<MovieDbRepository>((Injector injector) {
    final MovieDbClient client = injector.getDependency<MovieDbClient>();
    final MovieDbCache cache = injector.getDependency<MovieDbCache>();
    return MovieDbRepository(client, cache);
  });
  injector.registerDependency<AuthenticationBloc>((Injector injector) {
    final MovieDbRepository repository = injector.getDependency<MovieDbRepository>();
    return AuthenticationBloc(repository);
  });
  injector.registerDependency<MovieListBloc>((Injector injector) {
    final MovieDbRepository repository = injector.getDependency<MovieDbRepository>();
    return MovieListBloc(repository);
  });
  injector.registerDependency<MovieBloc>((Injector injector) {
    final MovieDbRepository repository = injector.getDependency<MovieDbRepository>();
    return MovieBloc(repository);
  });
}