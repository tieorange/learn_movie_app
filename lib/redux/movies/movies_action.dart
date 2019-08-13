import 'package:kt_dart/collection.dart';
import 'package:learn_movie_app/model/Movie.dart';

class FetchMoviesAction {
  final String sortBy;

  FetchMoviesAction(this.sortBy);
}

class MoviesFetchSuccessAction {
  final KtList<Movie> movies;

  MoviesFetchSuccessAction(this.movies);
}

class MoviesFetchErrorAction {
  final String error;

  MoviesFetchErrorAction(this.error);
}

class MoviesFetchCancelAction{}
