import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';
import '../utils/constants.dart';

class MovieProvider with ChangeNotifier {
  final MovieService _movieService = MovieService();
  final Connectivity _connectivity = Connectivity();

  List<Movie> _movies = [];
  List<Movie> _favorites = [];
  bool _isLoading = false;
  String _error = '';
  String _searchQuery = '';
  bool _showFavorites = false;
  bool _isConnected = true;

  List<Movie> get movies =>
      _showFavorites
          ? _favorites.where((m) => _matchesSearch(m)).toList()
          : _movies.where((m) => _matchesSearch(m)).toList();

  bool get isLoading => _isLoading;
  String get error => _error;
  bool get showFavorites => _showFavorites;
  bool get isConnected => _isConnected;

  MovieProvider() {
    _initConnectivity();
    _loadFavorites();
  }

  Future<void> _initConnectivity() async {
    _connectivity.checkConnectivity().then(_updateConnectionStatus);
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    _isConnected = results.any((result) => result != ConnectivityResult.none);
    notifyListeners();
  }

  bool _matchesSearch(Movie movie) {
    return movie.title.toLowerCase().contains(_searchQuery.toLowerCase());
  }

  Future<void> _loadFavorites() async {
    final box = await Hive.openBox<Movie>('favorites');
    _favorites = box.values.toList();
    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    _searchQuery = query;

    if (!_isConnected) {
      _error = AppConstants.noInternetMessage;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _movies = await _movieService.searchMovies(query);
      _error = '';
    } catch (e) {
      _error = e.toString();
      _movies = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(Movie movie) async {
    final box = await Hive.openBox<Movie>('favorites');

    if (box.containsKey(movie.imdbID)) {
      await box.delete(movie.imdbID);
    } else {
      await box.put(movie.imdbID, movie);
    }

    await _loadFavorites();
  }

  void toggleShowFavorites() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favorites.any((m) => m.imdbID == movie.imdbID);
  }
}
