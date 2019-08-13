import 'package:flutter/foundation.dart';
import 'package:kt_dart/collection.dart';
import 'package:learn_movie_app/model/Genre.dart';
import 'package:learn_movie_app/model/LoadingStatus.dart';
import 'package:learn_movie_app/model/Movie.dart';

class MoviesStateRedux {
  final LoadingStatus loadingStatus;
  final KtList<Movie> moviesState;
  final KtList<GenreModel> genresState;

  MoviesStateRedux({
    @required this.loadingStatus,
    @required this.moviesState,
    this.genresState,
  });

  factory MoviesStateRedux.initial() {
    return MoviesStateRedux(
        loadingStatus: LoadingStatus.idle,
        moviesState: KtList.empty(),
        genresState: KtList.empty());
  }

  MoviesStateRedux copyWith({LoadingStatus loadingStatus}) {
    return MoviesStateRedux(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        moviesState: moviesState ?? this.moviesState,
        genresState: genresState ?? this.genresState);
  }
}
