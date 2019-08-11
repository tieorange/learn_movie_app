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
import 'package:learn_movie_app/ui/util/NavigationController.dart';

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
            } else if (state is MoviesLoading) {
              return Center(child: Text("Loading"));
            } else if (state is MoviesFetched) {
              return MoviesList(movies: state.movies.results);
            }

            return Center(child: Text(state.props.toString()));
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
    var screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (_, int index) {
        var movie = movies.elementAt(index);

        return Container(
          padding: const EdgeInsets.all(20.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: new Border.all(color: Colors.white, width: 0.8)),
            child: Stack(
              children: <Widget>[
                movieItemTextContent(movie, screenWidth, context),
                new MovieImage(
                    movieImageHeight: movieImageHeight,
                    movieImageWidth: movieImageWidth,
                    movie: movie),
              ],
            ),
          ),
        );
      },
    );
  }

  void onTapItem(BuildContext context, Movie movie) {
    NavigationController.openDetails(movie, context);
  }

  static const movieImageWidth = 90.0;
  static const movieImageHeight = 130.0;

  Widget movieItemTextContent(
      Movie movie, double screenWidth, BuildContext context) {
    var cardBorderRadius = BorderRadius.circular(16);
    return Container(
      padding: EdgeInsets.all(6),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
              elevation: 4,
              child: InkWell(
                borderRadius: cardBorderRadius,
                onTap: () {
                  onTapItem(context, movie);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: movieImageWidth + 10,
                      top: 16,
                      bottom: 16,
                      right: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        movieTitle(movie),
                        SizedBox(height: 2),
                        movieRating(),
                        SizedBox(height: 8),
                        movieTags()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget movieTitle(Movie movie) {
    return Text(
      movie.title,
      maxLines: 2,
    );
  }

  Widget movieRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.orangeAccent,
        ),
        Text("8.5/10 IMDb  3h 10min"),
      ],
    );
  }

  Widget movieTags() {
    return Transform(
      transform: Matrix4.identity()..scale(0.8),
      child: Row(children: <Widget>[
        Chip(label: Text("fantasy")),
        SizedBox(width: 10),
        Chip(label: Text("fantasy"))
      ]),
    );
  }
}

class MovieImage extends StatelessWidget {
  final double movieImageHeight;
  final double movieImageWidth;
  final Movie movie;

  const MovieImage({
    Key key,
    this.movieImageHeight = 100,
    @required this.movieImageWidth,
    @required this.movie,
  }) : super(key: key);

  final String movieLink = "https://source.unsplash.com/random/600×400";

  @override
  Widget build(BuildContext context) {
    movie.backdropPath = movieLink;

    return Hero(
      transitionOnUserGestures: true,
      tag: movie.title,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          height: movieImageHeight,
          width: movieImageWidth,
          image: movie.posterPath,
          placeholder: "",
        ),
      ),
    );
  }
}
