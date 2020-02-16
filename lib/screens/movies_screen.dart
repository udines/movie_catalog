import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_list_bloc.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_list_event.dart';
import 'package:flutter_movie_catalog/blocs/movies/movie_list_state.dart';
import 'package:flutter_movie_catalog/models/movies/movie_list.dart';
import 'package:injector/injector.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MoviesScreen> {
  int _selectedIndex = 0;
  static Injector _injector;
  MovieListBloc _bloc;

  @override
  void initState() {
    _injector = Injector.appInstance;
    _bloc = _injector.getDependency<MovieListBloc>();
    _bloc.add(const NowPlayingRequested(1));
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieListBloc>(
      create: (BuildContext context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movies')
        ),
        body: Container(
          child: BlocBuilder<MovieListBloc, MovieListState>(
            bloc: _bloc,
            builder: (BuildContext context, MovieListState state) {
              if (state is MovieNotFound) {
                return const Center(child: Text('No movie found'));
              } else if (state is NoMovies) {
                return const Center(child: Text('No movies'));
              } else if (state is GetMoviesLoading) {
                return const Center(child: CircularProgressIndicator(),);
              } else if (state is GetMoviesSuccess) {
                final MovieList movieList = state.movies;
                return ListView.builder(
                  itemCount: movieList.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    final MovieItem movie = movieList.results[index];
                    return Card(
                      child: ListTile(
                        title: Text(movie.title),
                        subtitle: Text(movie.releaseDate),
                      )
                    );
                  }
                );
              } else if (state is GetMoviesError) {
                final String errorMessage = state.error.statusMessage;
                return Center(child: Text(errorMessage));
              } else {
                return const Center(child: Text('No movies'));
              }
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              title: Text('Now Playing')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              title: Text('Popular')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              title: Text('Top Rated')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              title: Text('Upcoming')
            )
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            _onItemTapped(index);
            if (index == 0) {
              _bloc.add(const NowPlayingRequested(1));
            } else if (index == 1) {
              _bloc.add(const PopularRequested(1));
            } else if (index == 2) {
              _bloc.add(const TopRatedRequested(1));
            } else if (index == 3) {
              _bloc.add(const UpcomingRequested(1));
            }
          },
        ),
      )
    );
  }
}