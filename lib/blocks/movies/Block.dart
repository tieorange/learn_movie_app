import 'package:bloc/bloc.dart';
import 'package:learn_movie_app/blocks/movies/States.dart';
import 'package:learn_movie_app/blocks/movies/Events.dart';
import 'package:learn_movie_app/model/Movie.dart';
import 'package:learn_movie_app/repository/MoviesRepository.dart';

class MoviesBlock extends Bloc<MovieEvent, MoviesState> {
  final MoviesRepository repository;

  MoviesBlock(this.repository);

  @override
  MoviesState get initialState => MoviesEmpty();

  @override
  Stream<MoviesState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMovies) {
      yield MoviesLoading();
      try {
        MovieResponseModel response = await repository.getMovies();
        yield MoviesFetched(response);
      } catch (_) {
        yield MoviesError();
      }
    }
  }
}
