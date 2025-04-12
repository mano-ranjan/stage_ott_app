import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../utils/constants.dart';

class MovieService {
  static const _baseUrl = 'www.omdbapi.com';

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(
      Uri.https(_baseUrl, '', {
        'apikey': AppConstants.omdbApiKey,
        's': query,
        'type': 'movie',
        'r': 'json',
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        return (data['Search'] as List)
            .map((json) => Movie.fromJson(json))
            .toList();
      }
      throw Exception(data['Error'] ?? 'No movies found');
    }
    throw Exception('Failed to load movies');
  }

  Future<Movie> getMovieDetails(String imdbID) async {
    final response = await http.get(
      Uri.https(_baseUrl, '', {
        'apikey': AppConstants.omdbApiKey,
        'i': imdbID,
        'plot': 'full',
        'r': 'json',
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        return Movie.fromJson(data);
      }
      throw Exception(data['Error'] ?? 'Failed to load details');
    }
    throw Exception('Failed to load movie details');
  }
}
