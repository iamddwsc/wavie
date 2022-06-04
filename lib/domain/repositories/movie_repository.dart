import 'package:wavie/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getTrending();

  Future<List<MovieEntity>> getTop10();

  Future<List<MovieEntity>> getPopular();
}
