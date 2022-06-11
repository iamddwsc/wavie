import 'package:wavie/data/models/movie_model.dart';
import 'package:wavie/domain/entities/movie_detail_entity.dart';
import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/domain/entities/movie_search_params.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getTrending();
  Future<List<MovieEntity>> getTop10();
  Future<List<MovieEntity>> getPopular();
  Future<MovieDetailEntity> getMovieDetail(int id);
  Future<List<MovieModel>> getSearchedMovie(String query);
}
