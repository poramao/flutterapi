import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/movie.dart';

class HttpHelper {
  static const String _baseUrl =
      'https://api.themoviedb.org/3/movie';

  static const String _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NWFkMzIyMWY0NDc5OWM1MjMwMDJhMmUyNmU5MDAxNyIsIm5iZiI6MTc3MDc0MDM0OC4xODksInN1YiI6IjY5OGI1YTdjMmRjYWU0YjgxYmM3MzM0NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rJf4vFjPRRuOyNdkxcI5EWgiVtMYHmrNCuvW8arRGsc';


  Future<List<Movie>> getUpcomingMovies() async {
    final uri = Uri.parse('$_baseUrl/upcoming')
        .replace(queryParameters: {
      'language': 'en-US',
    });

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $_token',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List results = jsonData['results'];

      return results
          .map((e) => Movie.fromJson(e))
          .toList();
    } else {
      throw Exception(
        'HTTP ${response.statusCode}: ${response.body}',
      );
    }
  }
}// TODO Implement this library.