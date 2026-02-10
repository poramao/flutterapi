import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie.dart';

class HttpHelper {

  final String urlKey = 'api_key=[eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMmNkYTRiM2UyN2MyYjczNzBmODZkZjg3YWE3ZmY3NCIsIm5iZiI6MTc3MDczNDY4OS41MDg5OTk4LCJzdWIiOiI2OThiNDQ2MTgxMDRmMDQ4N2Y4ZWZjYWEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.-Q6FTDMlJZQCBjMf97U77onX47Uy_5kiCMtCQLsdR14]';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';

  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=e3fd37e8dd3eca6eecb8808906be73bc&query=';

  Future<List<Movie>> getUpcoming() async {

    final String upcoming =
        urlBase + urlUpcoming + urlKey + urlLanguage;

    final result = await http.get(Uri.parse(upcoming));

    if (result.statusCode == HttpStatus.ok) {

      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];

      List<Movie> movies =
          moviesMap.map<Movie>((i) => Movie.fromJson(i)).toList();

      return movies;

    } else {

      return [];
    }
  }

  Future<List<Movie>> findMovies(String title) async {

    final String query = urlSearchBase + title;

    final result = await http.get(Uri.parse(query));

    if (result.statusCode == HttpStatus.ok) {

      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];

      List<Movie> movies =
          moviesMap.map<Movie>((i) => Movie.fromJson(i)).toList();

      return movies;

    } else {

      return [];
    }
  }
}
