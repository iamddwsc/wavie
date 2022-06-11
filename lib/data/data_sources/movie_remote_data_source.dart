import 'package:wavie/data/models/movie_model.dart';
import 'package:wavie/domain/entities/movie_detail_entity.dart';
import 'package:wavie/domain/entities/movie_entity.dart';

import '../../domain/entities/movie_search_params.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();

  Future<List<MovieModel>> getTop10();

  Future<List<MovieModel>> getPopular();

  Future<MovieDetailEntity> getMovieDetail(int movieId);

  Future<List<MovieModel>> getSearchedMovie(String query);
}
