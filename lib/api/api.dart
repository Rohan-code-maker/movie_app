import 'dart:convert';

import 'package:movie_app/constants.dart';

import '../models/movie.dart';
import 'package:http/http.dart' as http;

class Api{
  static const _trendingUrl = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';

  static const _topRatedUrl = 'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';

  static const _upComingMoviesUrl = 'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';

  static const _popularMoviesUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=${Constants.apiKey}';

  static const _searchMoviesUrl = 'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}';

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception("Something is Error");
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(_topRatedUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception("Something is Error");
    }
  }

  Future<List<Movie>> getUpComingMovies() async {
    final response = await http.get(Uri.parse(_upComingMoviesUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception("Something is Error");
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(_popularMoviesUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception("Something is Error");
    }
  }

  Future<List<Movie>> searchMovies() async {
    final response = await http.get(Uri.parse(_searchMoviesUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception("Something is Error");
    }
  }
}