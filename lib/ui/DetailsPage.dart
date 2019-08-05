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
            children: <Widget>[
              header(widget.movie),
              movieInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(Movie movie) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      height: 200,
      child: Stack(children: <Widget>[
        MovieImage(
          movie: movie,
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
            categoryChips()
          ],
        )
      ]),
    );
  }

  Row categoryChips() {
    return Row(
      children: <Widget>[
        Chip(label: Text("adventure")),
        Chip(label: Text("comedy")),
      ],
    );
  }

  Widget movieInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(widget.movie.overview),
    );
  }
}
