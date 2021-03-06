import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/src/models/movie_entity.dart';
import 'package:movies_app/src/providers/movie_provider.dart';
import 'package:movies_app/src/widgets/detail_app_bar_sliver.dart';
import 'package:movies_app/src/widgets/movie_poster.dart';
import 'package:movies_app/src/widgets/movies_horizontal.dart';


class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MovieEntity movie = ModalRoute.of(context).settings.arguments;

    movieProvider.getSimilarMovies(movie.id.toString());

    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            DetailAppBarSliver(
                title: movie.title,
                backdrop: NetworkImage(movie.getBackdropImage())
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                  [
                    _buildPoster(context: context, movie: movie),
                    _buildDescription(movie.overview),
                    _buildDescription(movie.overview),
                    _buildDescription(movie.overview),
                    _buildTitle('Similar'),
                    MoviesHorizontal(moviesStream: movieProvider.similarMoviesStream, getMoreMovies: () {})
                  ]
              ),
            )
          ],
        )
    );
  }
}


Widget _buildDescription (String description) {
  return Container(
      margin: EdgeInsets.all(20.0),
      child: Text(description)
  );
}

Widget _buildTitle (String title) {
  return Container(
      margin: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
      child: Text(title, style: TextStyle(fontSize: 24.0))
  );
}

Widget _buildPoster ({ MovieEntity movie, @required BuildContext context }) {
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: <Widget>[
        MoviePoster(
            posterId: 'poster-${movie.id}',
            poster: NetworkImage(movie.getPosterImage()),
            onPressed: () {}
        ),
        SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(movie.title, style: Theme.of(context).textTheme.title),
              Text(movie.releaseDate, style: Theme.of(context).textTheme.subtitle),
              Row(
                children: <Widget>[
                  Icon(Icons.stars),
                  SizedBox(width: 5.0),
                  Text(movie.voteAverage.toString())
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
