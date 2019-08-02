import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_movie_app/model/Movie.dart';
import 'package:learn_movie_app/ui/DetailsPage.dart';

class NavigationController {
  static void openDetails(Movie movie, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailsPage(movie: movie)));
  }
}
