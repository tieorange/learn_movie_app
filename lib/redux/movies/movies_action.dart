import 'package:kt_dart/collection.dart';
import 'package:learn_movie_app/model/Movie.dart';

class FetchMoviesAction {
  final String sortBy;

  FetchMoviesAction(this.sortBy);
}

class MoviesFetchSuccess {
  final KtList<Movie> movies;

  MoviesFetchSuccess(this.movies);
}

class MoviesFetchError {
  final String error;

  MoviesFetchError(this.error);
}
