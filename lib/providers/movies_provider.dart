import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app_flutter/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  static const _apiKey = 'ec43a22728c6531c11a5f81fb6806031';
  static const _baseURl = 'api.themoviedb.org';
  static const _language = 'en-US';

  MoviesProvider() {
    getOnDisplayMovies();
  }

  Future<void> getOnDisplayMovies() async {
    final url = Uri.https(_baseURl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
  }
}