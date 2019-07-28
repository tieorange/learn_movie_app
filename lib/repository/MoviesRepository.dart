import 'package:learn_movie_app/model/Movie.dart';
import 'package:learn_movie_app/repository/ApiProvider.dart';

class MoviesRepository{
  final ApiProvider apiProvider;

  MoviesRepository(this.apiProvider);

  Future<MovieResponseModel> getMovies() async{
    return apiProvider.fetchMovieList();
  }
}