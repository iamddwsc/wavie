import 'dart:convert';

import 'package:http/http.dart';
import 'package:wavie/common/constants/api_constants.dart';
import 'package:wavie/data/core/api_client.dart';
import 'package:wavie/data/data_sources/movie_remote_data_source.dart';
import 'package:wavie/data/models/movie_detail_result_model.dart';
import 'package:wavie/data/models/movie_model.dart';
import 'package:wavie/data/models/movie_result_model.dart';
import 'package:wavie/domain/entities/movie_detail_entity.dart';
import 'package:wavie/domain/entities/movie_entity.dart';

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    //TODO: Fetch Trending Movies
    try {
      final response = await _client.get(
        // 1
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.GET10),
      );
      final movies = MovieResultModel.fromJson(response).movies;
      // 6
      return movies!;
    } catch (e) {
      //print(e);
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getTop10() async {
    // TODO: implement getTop10

    final response = await _client.get(
      // 1
      Uri.parse(ApiConstants.BASE_URL + ApiConstants.GET10),
    );
    // 3
    final movies = MovieResultModel.fromJson(response).movies;
    // 6
    return movies!;
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    // TODO: implement getPopular
    final response = await _client.get(
      // 1
      Uri.parse(ApiConstants.BASE_URL + ApiConstants.GETPOPULAR),
    );
    final movies = MovieResultModel.fromJson(response).movies;
    // 6
    return movies!;
  }

  @override
  Future<MovieDetailEntity> getMovieDetail(int movieId) async {
    // TODO: implement getMovieDetail
    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await _client.post(
        // 1
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.GET_MOVIE_DETAIL),
        params: {'id': movieId.toString()},
      );
      final movie = MovieDetailResultModel.fromJson(response).movie;
      // 6
      return movie!;
    } catch (e) {
      //print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getSearchedMovie(String query) async {
    // TODO: implement getSearchedMovie
    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await _client.post(
        // 1
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.SEARCH_MOVIE),
        params: {'query': query.toString()},
      );
      final movie = MovieResultModel.fromJson(response).movies!;
      return movie;
    } catch (e) {
      //print(e.toString() + 'ABC');
      rethrow;
    }
  }
}
