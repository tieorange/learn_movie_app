import 'package:equatable/equatable.dart';
import 'package:learn_movie_app/model/Movie.dart';

abstract class MoviesStateBloc extends Equatable {
  MoviesStateBloc([List props = const []]) : super(props);
}

class MoviesEmpty extends MoviesStateBloc {}

class MoviesLoading extends MoviesStateBloc {}

class MoviesFetched extends MoviesStateBloc {
  final MovieResponseModel movies;

  MoviesFetched(this.movies);
}

class MoviesError extends MoviesStateBloc {}
