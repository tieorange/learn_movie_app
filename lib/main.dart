import 'package:flutter/material.dart';
import 'package:learn_movie_app/ui/HomePage.dart';

//https://github.com/sagarprince/flutter_movies_app/blob/master/lib/app/resources/api_provider.dart

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Widget buildItem() {
    return Row(
        children: <Widget>[
          Material(elevation: 4)]
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}