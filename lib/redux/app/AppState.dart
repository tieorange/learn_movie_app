import 'package:flutter/foundation.dart';
import 'package:kt_dart/collection.dart';
import 'package:learn_movie_app/model/Genre.dart';
import 'package:learn_movie_app/model/LoadingStatus.dart';
import 'package:learn_movie_app/model/Movie.dart';

@immutable
class AppState {
  final LoadingStatus loadingStatus;
  final KtList<Movie> movies;
  final KtList<GenreModel> genres;

  AppState({
    @required this.loadingStatus,
    @required this.movies,
    this.genres,
  });

  factory AppState.initial() {
    return AppState(
        loadingStatus: LoadingStatus.idle,
        movies: KtList.empty(),
        genres: KtList.empty());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          loadingStatus == other.loadingStatus &&
          movies == other.movies &&
          genres == other.genres;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^ movies.hashCode ^ genres.hashCode;
}
