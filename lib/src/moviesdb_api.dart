import 'dart:async';
import 'dart:convert';
import 'package:kt_dart/collection.dart';
import 'package:http/http.dart';
import 'package:movies_app/src/config.dart';

import 'package:movies_app/src/models/movie_entity.dart';

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
  };

  set setLanguage (String lang) {
    defaultLanguage = lang;
  }

  String _setApiVersion(String path) {
    return '/$apiVersion/$path';
  }

  Future<KtList<MovieEntity>> getNowPlaying () async {
    Uri uri = Uri.https(baseUrl, _setApiVersion(endpoints['nowPlaying']), {
      'language': defaultLanguage,
      'api_key': apiKey
    });

    Response response = await _client.get(uri);

    Map decoded = jsonDecode(response.body);

    List results = decoded['results'];

    return listFrom(results).map((item) => MovieEntity.fromJson(item));
  }
}

MoviesDBAPI moviesDBAPI = new MoviesDBAPI(apiKey: mdbApiKey, baseUrl: mdbBaseAPIUrl, apiVersion: mdbApiVersion);