import 'dart:async';

import 'package:kt_dart/collection.dart';
import 'package:movies_app/src/models/movie_entity.dart';
import 'package:movies_app/src/moviesdb_api.dart';

class MovieProvider {

  KtList<MovieEntity> _popularMovies = emptyList();
  int _currentPopularMoviesPage = 1;

  final _popularMoviesStreamController = StreamController<KtList<MovieEntity>>.broadcast();
  final _featuredMoviesStreamController = StreamController<KtList<MovieEntity>>.broadcast();
  final _similarMoviesStreamController = StreamController<KtList<MovieEntity>>.broadcast();

  // Featured Movies
  Function(KtList<MovieEntity>) get featuredMoviesSick => _featuredMoviesStreamController.sink.add;
  Stream<KtList<MovieEntity>> get featuredMoviesStream => _featuredMoviesStreamController.stream;

  // PopularMovies
  Function(KtList<MovieEntity>) get popularMoviesSick => _popularMoviesStreamController.sink.add;
  Stream<KtList<MovieEntity>> get popularMoviesStream => _popularMoviesStreamController.stream;

  // SimilarMovies
  Function(KtList<MovieEntity>) get similarMoviesSick => _similarMoviesStreamController.sink.add;
  Stream<KtList<MovieEntity>> get similarMoviesStream => _similarMoviesStreamController.stream;

  void getFeaturedMovies (moviesDBAPIEndpoints endpoint) async {
    KtList<MovieEntity> result = await moviesDBAPI.getMovies(endpoint);

    featuredMoviesSick(result);
  }

  void getSimilarMovies (String movieId) async {
    KtList<MovieEntity> result = await moviesDBAPI.getMovies(moviesDBAPIEndpoints.SIMILAR
    );


    similarMoviesSick(result);
  }

  void getPopularMovies () async {
    KtList<MovieEntity> result = await moviesDBAPI.getMovies(moviesDBAPIEndpoints.POPULAR, {
      "page": _currentPopularMoviesPage.toString()
    });

    _currentPopularMoviesPage++;

    _popularMovies = _popularMovies.plus(result);

    popularMoviesSick( _popularMovies );
  }

  void disposeStream() {
    _featuredMoviesStreamController?.close();
    _popularMoviesStreamController?.close();
    _similarMoviesStreamController?.close();
  }
}


final movieProvider = new MovieProvider();
