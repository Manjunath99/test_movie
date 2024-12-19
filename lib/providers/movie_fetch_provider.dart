import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_test/model/movie_model.dart';


class PostProvider with ChangeNotifier {
  List<Movie> _posts = [];
  bool _loading = false;
  String _errorMessage = '';

  List<Movie> get posts => _posts;
  bool get isLoading => _loading;
  String get errorMessage => _errorMessage;


  Future<void> fetchPosts() async {
    _loading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://run.mocky.io/v3/746f29d3-4a2a-4a9f-be39-df409f3d3a7f'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _posts = data.map((e) => Movie.fromJson(e)).toList();
        _errorMessage = '';
      } else {
        _errorMessage = 'Failed to load posts';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    }

    _loading = false;
    notifyListeners();
  }
  List<String> getUniqueYears() {
    return _posts.map((movie) => movie.year).toSet().toList();
  }

  // Unique Genres
  List<String> getUniqueGenres() {
    return _posts.expand((movie) => movie.genre.split(', ')).toSet().toList();
  }

  // Unique Directors
  List<String> getUniqueDirectors() {
    return _posts.map((movie) => movie.director).toSet().toList();
  }

  // Unique Actors
  List<String> getUniqueActors() {
    return _posts.expand((movie) => movie.actors.split(', ')).toSet().toList();
  }

  // All Movie Titles
  List<String> getAllMovieTitles() {
    return _posts.map((movie) => movie.title).toList();
  }
  List<Movie> searchMovies({
    String? actor,
    String? year,
    String? genre,
    String? director,
  }) {
    return _posts.where((movie) {
      final matchesActor = actor == null || movie.actors.contains(actor);
      final matchesYear = year == null || movie.year == year;
      final matchesGenre = genre == null || movie.genre.contains(genre);
      final matchesDirector = director == null || movie.director == director;

      return matchesActor && matchesYear && matchesGenre && matchesDirector;
    }).toList();
  }

}
