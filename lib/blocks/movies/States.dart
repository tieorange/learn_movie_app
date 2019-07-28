import 'package:equatable/equatable.dart';
import 'package:learn_movie_app/model/Movie.dart';

abstract class MoviesState extends Equatable {
  MoviesState([List props = const []]) : super(props);
}

class MoviesEmpty extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesFetched extends MoviesState {
  final MovieResponseModel movies;

  MoviesFetched(this.movies);
}

class MoviesError extends MoviesState {}
