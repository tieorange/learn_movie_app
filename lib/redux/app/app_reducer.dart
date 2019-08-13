import 'package:kt_dart/src/collection/kt_list.dart';
import 'package:learn_movie_app/model/Movie.dart';

import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(moviesState: state.moviesState);
}
