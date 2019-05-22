import 'package:flutter/material.dart';
import 'package:kt_dart/kt.dart';
import 'package:movies_app/src/models/movie_entity.dart';


class MoviesHorizontal extends StatelessWidget {
  MoviesHorizontal({ @required this.moviesStream, @required this.getMoreMovies });


  final Stream<KtList<MovieEntity>> moviesStream;
  final Function getMoreMovies;
  final PageController _pageController = new PageController(initialPage: 1, viewportFraction: 0.3);


  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {

      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200)
        getMoreMovies();

    });

    return Container(
      height: _screenSize.height * 0.2,
      child: StreamBuilder(
        stream: moviesStream,
        builder: (BuildContext context, AsyncSnapshot<KtList<MovieEntity>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.redAccent)
                  )
              );
            case ConnectionState.active:
            default:
              return PageView.builder(
                controller: _pageController,
                itemCount: snapshot.data.size,
                pageSnapping: false,
                itemBuilder: (BuildContext ctx, index) {
                  final MovieEntity item = snapshot.data.get(index);
                  return _buildCard(ctx, item);
                },
              );
          }
        },
      ),
    );
  }
}

Widget _buildCard (BuildContext context, MovieEntity movie) {
  String posterId = "poster-${movie.id}";

  return Container(
    margin: EdgeInsets.only(right: 15.0),
    child: Column(
      children: <Widget>[
        Hero(
          tag: posterId,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImage()),
                placeholder: AssetImage('assets/images/placeholder.png'),
                fit: BoxFit.cover,
                height: 160.0,
              )
          ),
        ),
      ],
    ),
  );
}
