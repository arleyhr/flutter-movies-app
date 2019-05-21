import 'dart:async';

import 'package:kt_dart/collection.dart';
import 'package:movies_app/src/models/movie_entity.dart';
import 'package:movies_app/src/moviesdb_api.dart';

class MovieProvider {

  final _featuredMoviesStreamController = StreamController<KtList<MovieEntity>>.broadcast();

  Function(KtList<MovieEntity>) get featuredMoviesSick => _featuredMoviesStreamController.sink.add;

  Stream<KtList<MovieEntity>> get featuredMoviesStream => _featuredMoviesStreamController.stream;

  getFeaturedMovies (moviesDBAPIEndpoints endpoint) async {
    KtList<MovieEntity> result = await moviesDBAPI.getMovies(endpoint);

    featuredMoviesSick(result);

  }

  void disposeStream() {
    _featuredMoviesStreamController?.close();
  }
}


final movieProvider = new MovieProvider();
