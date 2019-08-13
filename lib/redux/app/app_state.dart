import 'package:flutter/foundation.dart';
import 'package:learn_movie_app/blocks/movies/States.dart';

@immutable
class AppState {
  final MoviesStateBloc moviesState;

  AppState({@required this.moviesState});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          moviesState == other.moviesState;

  @override
  int get hashCode => moviesState.hashCode;
}
