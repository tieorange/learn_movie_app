import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  MovieEvent([List props = const []]) : super(props);
}

class FetchMovies extends MovieEvent {
  final int count;

  FetchMovies(this.count);
}