import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_movie_app/blocks/movies/Block.dart';
import 'package:learn_movie_app/blocks/movies/Events.dart';
import 'package:learn_movie_app/blocks/movies/States.dart';
import 'package:learn_movie_app/di/Injector.dart';
import 'package:learn_movie_app/model/Movie.dart';
import 'package:learn_movie_app/repository/MoviesRepository.dart';

class HomePage extends StatefulWidget {
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
        child: BlocBuilder(
          bloc: _moviesBlock,
          builder: (_, MoviesState state) {
            if (state is MoviesEmpty) {
              return Center(child: Text("Empty"));
            }
            if (state is MoviesLoading) {
              return Center(child: Text("Loading"));
            }
            if (state is MoviesFetched) {
              return MoviesList(movies: state.movies.results);
            }

            return Center(child: Text("Error"));
          },
        ),
      ),
    );
  }
}

class MoviesList extends StatelessWidget {
  const MoviesList({Key key, @required this.movies}) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (_, int index) {
        var movie = movies.elementAt(index);

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: DecoratedBox(
            decoration:
                BoxDecoration(border: new Border.all(color: Colors.blue)),
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[movieItemContent(movie)],
                ),
                movieItemImage(movie),
              ],
            ),
          ),
        );
      },
    );
  }

  FadeInImage movieItemImage(Movie movie) {
    return FadeInImage.assetNetwork(
      height: 100,
      image:
          "https://vignette.wikia.nocookie.net/marvelmovies/images/6/68/MIB_International_poster.jpg/revision/latest?cb=20190425170942",
      placeholder: "",
    );
  }

  Widget movieItemContent(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Material(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 80, top: 16, bottom: 16, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(movie.title),
                  movieRating(),
                  movieTags()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget movieRating() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.orangeAccent,
        ),
        Text("8.5/10 IMDb  3h 10min"),
      ],
    );
  }

  movieTags() {
    return Wrap(children: <Widget>[
      Chip(label: Text("fantasy")),
      Chip(label: Text("fantasy"))
    ]);
  }
}
