import 'package:flutter/material.dart';
import 'package:movies_app/src/pages/home.dart';
import 'package:movies_app/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      title: 'Movies',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'movieDetail': (BuildContext context) => MovieDetail()
      },
    );
  }
}

