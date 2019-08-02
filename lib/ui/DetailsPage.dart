import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_movie_app/model/Movie.dart';

import 'HomePage.dart';

class DetailsPage extends StatefulWidget {
  final Movie movie;

  DetailsPage({this.movie});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextTheme textTheme;
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[header(widget.movie)],
          ),
        ),
      ),
    );
  }

  Widget header(Movie movie) {
    return Stack(children: <Widget>[
      MovieImage(
        movie: movie,
        movieImageHeight: 200,
        movieImageWidth: screenWidth,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            movie.title,
            style: textTheme.title.copyWith(color: Colors.white),
          ),
        ],
      )
    ]);
  }

  movieInfo() {}
}
