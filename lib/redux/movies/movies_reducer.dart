import 'package:learn_movie_app/model/LoadingStatus.dart';
import 'package:learn_movie_app/redux/movies/movies_action.dart';
import 'package:learn_movie_app/redux/movies/movies_state.dart';
import 'package:learn_movie_app/redux/movies/movies_state.dart';

MoviesStateRedux moviesReducer(MoviesStateRedux state, dynamic action){
  if(action is FetchMoviesAction){
    return state.copyWith(loadingStatus: LoadingStatus.loading);
  }
}