import 'package:kt_dart/collection.dart';
import 'package:learn_movie_app/model/Movie.dart';
import 'package:learn_movie_app/redux/app/AppState.dart';
import 'package:learn_movie_app/redux/movies/movies_action.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class MoviesMiddleware extends MiddlewareClass<AppState>{



  Future<KtList<Movie>> _fetchMovies(){

  }

  Stream<dynamic> exampleEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
    return new Observable(actions)
        .ofType(new TypeToken<FetchMoviesAction>)
}