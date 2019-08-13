import 'package:learn_movie_app/model/Movie.dart';
import 'package:learn_movie_app/redux/app/app_state.dart';
import 'package:learn_movie_app/redux/movies/movies_action.dart';
import 'package:learn_movie_app/repository/MoviesRepository.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class MoviesMiddleware extends EpicMiddleware {
  final MoviesRepository _moviesRepository;

  MoviesMiddleware(Epic epic, this._moviesRepository) : super(epic);

  Stream<dynamic> exampleEpic(
      Stream<dynamic> actions, EpicStore<AppState> store) {
    return new Observable(actions)
        .ofType(new TypeToken<FetchMoviesAction>())
        .asyncMap((action) => _moviesRepository
            .getMovies()
            .then((MovieResponseModel results) =>
                new MoviesFetchSuccessAction(results.map()))
            .catchError((error) => new MoviesFetchErrorAction(error)))
        .takeUntil(actions.where((action) => action is MoviesFetchCancelAction));
  }
}
