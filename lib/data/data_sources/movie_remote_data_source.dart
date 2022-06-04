import 'package:wavie/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();

  Future<List<MovieModel>> getTop10();

  Future<List<MovieModel>> getPopular();
}
