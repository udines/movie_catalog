import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_catalog/models/movies/movie_list.dart';

class MovieItemView extends StatelessWidget {
  const MovieItemView({this.movie});

  final MovieItem movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Center(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Image.network('http://image.tmdb.org/t/p/w185/' + movie.posterPath),
            ),
            Text(movie.title, textAlign: TextAlign.center,),
            Text(movie.releaseDate, textAlign: TextAlign.center,)
          ],
        )
      )
    );
  }
}