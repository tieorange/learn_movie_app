import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_movie_app/model/Movie.dart';

import 'HomePage.dart';

// https://deploygate.com/settings = 9f6ddb4e8b50f7a790fd472f5412d706ba23b7ed
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
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text(widget.movie.title)),
      ),
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
    var movieImageHeight = 200.0;

    return Container(
      margin: EdgeInsets.only(top: 16),
      height: movieImageHeight,
      child: Stack(children: <Widget>[
        MovieImage(
          movie: movie,
          movieImageWidth: screenWidth,
          movieImageHeight: movieImageHeight,
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
