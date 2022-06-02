import 'dart:convert';

import 'package:http/http.dart';
import 'package:wavie/common/api_constants.dart';
import 'package:wavie/data/data_sources/movie_remote_data_source.dart';
import 'package:wavie/data/models/movie_model.dart';
import 'package:wavie/data/models/movie_result_model.dart';

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final Client _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    //TODO: Fetch Trending Movies
    //print(ApiConstants.BASE_URL + ApiConstants.GET10);
    final response = await _client.get(
        // 1
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.GET10),
        // 2
        headers: {
          'Content-Type': 'application/json',
        });
    // 3
    if (response.statusCode == 200) {
      // 4
      final responseBody = json.decode(response.body);
      // 5
      //final List x = responseBody['result'];
      final movies = MovieResultModel.fromJson(responseBody).movies;
      //print(movies![0].toJson());
      // 6
      //print(movies);
      return movies!;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
