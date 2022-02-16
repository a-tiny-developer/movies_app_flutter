import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app_flutter/helpers/helpers.dart';
import 'package:movies_app_flutter/models/models.dart';
import 'package:movies_app_flutter/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  static const _apiKey = 'API_KEY';
  static const _baseURl = 'api.themoviedb.org';
  static const _language = 'en-US';

  var onDisplayMovies = <Movie>[];
  var popularMovies = <Movie>[];
  var _popularPage = 0;
  final moviesCast = <int, List<Cast>>{};

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  // Streams
  final _suggestionStreamController = StreamController<List<Movie>>.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;
  //

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String unencodedPath, [int page = 1]) async {
    final url = Uri.https(_baseURl, unencodedPath, {
      'api_key': _apiKey,
      'language': _language,
      'page': page.toString(),
    });
    final response = await http.get(url);
    return response.body;
  }

  Future<void> getOnDisplayMovies() async {
    final nowPlayingResponse =
        NowPlayingResponse.fromJson(await _getJsonData('3/movie/now_playing'));
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  Future<void> getPopularMovies() async {
    _popularPage++;
    final popularResponse = PopularResponse.fromJson(
        await _getJsonData('3/movie/popular', _popularPage));
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) {
      return moviesCast[movieId]!;
    }
    final creditsResponse = CreditsResponse.fromJson(
        await _getJsonData('3/movie/$movieId/credits'));
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String? query) async {
    final url = Uri.https(_baseURl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionByQuery(String searchTerm) {
    debouncer.start(() async {
      _suggestionStreamController.add(await searchMovie(searchTerm));
    });
  }
}
