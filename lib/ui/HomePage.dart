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
                  children: <Widget>[
                    movieItemImage(movie),
                    movieItemContent(movie)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  FadeInImage movieItemImage(Movie movie) {
    return FadeInImage.assetNetwork(
      height: 70,
      width: 50,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                    child: Container(
                      child: Text(
                        movie.title,
                      ),
                    ),
                    fit: FlexFit.loose),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
