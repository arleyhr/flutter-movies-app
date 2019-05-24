import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:kt_dart/collection.dart';
import 'package:movies_app/src/config.dart';
import 'package:movies_app/src/models/movie_entity.dart';

enum moviesDBAPIEndpoints {
  NOW_PLAYING,
  TOP_RATED,
  UPCOMING,
  POPULAR,
  SIMILAR
}

class MoviesDBAPI {
  MoviesDBAPI({
    this.apiKey,
    this.baseUrl,
    this.apiVersion,
    this.defaultLanguage = 'en-US'
  });

  final String apiKey;
  final String baseUrl;
  final String apiVersion;
  String defaultLanguage;

  Client _client = Client();

  static const Map<String, String> endpoints = {
    'nowPlaying': 'movie/now_playing',
    'topRated': 'movie/top_rated',
    'upcoming': 'movie/upcoming',
    'popular': 'movie/popular',
    'similar': 'movie/{movie_id}/similar'

  };

  String _replaceEndpointParams (String endpoint, [Map params = const {}]) {
    String output = endpoint;

    params.keys.forEach((key) {
      String value = params[key].toString();
      output = output.replaceAll('{$key}', value);
    });

    return output;
  }

  String _getEndpoint(moviesDBAPIEndpoints endpoint, [Map variables = const {}]) {
    switch(endpoint) {
      case moviesDBAPIEndpoints.NOW_PLAYING:
        return _setApiVersion(endpoints['nowPlaying'], variables);

      case moviesDBAPIEndpoints.TOP_RATED:
        return _setApiVersion(endpoints['topRated'], variables);

      case moviesDBAPIEndpoints.UPCOMING:
        return _setApiVersion(endpoints['upcoming'], variables);

      case moviesDBAPIEndpoints.POPULAR:
        return _setApiVersion(endpoints['popular'], variables);

      case moviesDBAPIEndpoints.SIMILAR:
        return _setApiVersion(endpoints['similar'], variables);

      default:
        return _setApiVersion(endpoints['nowPlaying'], variables);
    }

  }

  set setLanguage (String lang) {
    defaultLanguage = lang;
  }

  String _setApiVersion(String path, [Map variables]) {
    return '/$apiVersion/$path';
  }

  Future<KtList<MovieEntity>> getMovies (moviesDBAPIEndpoints type, [Map params = const {}]) async {
    Uri uri = Uri.https(baseUrl, _getEndpoint(type, params['variables'] ?? {}), {
      'language': defaultLanguage,
      'api_key': apiKey,
      ...params
    });

    Response response = await _client.get(uri);

    Map decoded = jsonDecode(response.body);

    List results = decoded['results'];

    return listFrom(results).map((item) => MovieEntity.fromJson(item));
  }
}

MoviesDBAPI moviesDBAPI = new MoviesDBAPI(apiKey: mdbApiKey, baseUrl: mdbBaseAPIUrl, apiVersion: mdbApiVersion);