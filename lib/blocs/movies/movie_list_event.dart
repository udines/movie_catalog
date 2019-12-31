import 'package:equatable/equatable.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();
}

class NowPlayingRequested extends MovieListEvent {
  const NowPlayingRequested(this.page);

  final int page;

  @override
  List<Object> get props => <Object>[];
}

class PopularRequested extends MovieListEvent {
  const PopularRequested(this.page);

  final int page;

  @override
  List<Object> get props => <int>[page];
}

class TopRatedRequested extends MovieListEvent {
  const TopRatedRequested(this.page);

  final int page;

  @override
  List<Object> get props => <int>[page];
}

class UpcomingRequested extends MovieListEvent {
  const UpcomingRequested(this.page);

  final int page;

  @override
  List<Object> get props => <int>[page];
}