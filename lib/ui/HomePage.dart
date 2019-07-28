import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_movie_app/blocks/movies/Block.dart';
import 'package:learn_movie_app/blocks/movies/Events.dart';
import 'package:learn_movie_app/blocks/movies/States.dart';
import 'package:learn_movie_app/di/Injector.dart';
import 'package:learn_movie_app/model/Movie.dart';
import 'package:learn_movie_app/repository/MoviesRepository.dart';

class HomePage extends StatefulWidget {
  List movies = ["SomeText32"];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MoviesRepository movieRepository = Injector.moviesRepository;
  MoviesBlock _moviesBlock;

  @override
  void initState() {
    super.initState();

    _moviesBlock = MoviesBlock(movieRepository);
    _moviesBlock.dispatch(FetchMovies(30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(children: <Widget>[
        BlocBuilder(
          bloc: _moviesBlock,
          builder: (_, MoviesState state) {
            if (state is MoviesEmpty) {
              return Center(child: Text("Empty"));
            }
            if (state is MoviesLoading) {
              return Center(child: Text("Loading"));
            }
            if (state is MoviesFetched) {
              return Center(child: MoviesFetchedPage(movies: state.movies.results));
            }

            return Center(child: Text("Error"));
          },
        ),
      ])),
    );
  }
}

class MoviesFetchedPage extends StatelessWidget {
  const MoviesFetchedPage({Key key, @required this.movies}) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Text(movies.first.title);
  }
}
