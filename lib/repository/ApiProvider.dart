import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:learn_movie_app/model/Genre.dart';
import 'package:learn_movie_app/model/Movie.dart';

class ApiProvider {
  final _apiKey = '2ffe2cefa3ecef9f33e2603f6f63936d';
  final _baseUrl = 'http://api.themoviedb.org/3';

  List<dynamic> genres = <dynamic>[];

  Future<List<GenreModel>> fetchGenresList() async {
    try {
      final response =
          await http.get("$_baseUrl/genre/movie/list?api_key=$_apiKey");
      if (response.statusCode == 200) {
        var result = GenreResponseModel.fromJson(json.decode(response.body));
        return result.genres;
      } else {
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      throw Exception('Something went wrong, please try again.');
    }
  }

  Future<MovieResponseModel> fetchMovieList() async {
    try {
      final genres = await fetchGenresList();
      final response =
          await http.get("$_baseUrl/movie/popular?api_key=$_apiKey");
      print(response.body);
      if (response.statusCode == 200) {
        return MovieResponseModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      print(e);
      throw Exception('Something went wrong, please try again.');
    }
  }
}
