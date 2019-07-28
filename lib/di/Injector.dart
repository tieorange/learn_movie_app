import 'package:learn_movie_app/repository/ApiProvider.dart';
import 'package:learn_movie_app/repository/MoviesRepository.dart';

class Injector {
  static final MoviesRepository moviesRepository =
      new MoviesRepository(new ApiProvider());
}
