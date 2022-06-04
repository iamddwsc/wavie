import 'dart:math';

import 'package:wavie/data/data_sources/movie_remote_data_source.dart';
import 'package:wavie/data/models/movie_model.dart';
import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MovieModel>> getTrending() async {
    // TODO: implement getTrending
    try {
      final movies = await remoteDataSource.getTrending();
      print(movies);
      return movies;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<MovieEntity>> getTop10() async {
    // TODO: implement getTop10
    try {
      final movies = await remoteDataSource.getTop10();
      return movies;
    } catch (e) {
      throw List<MovieEntity>;
    }
  }

  @override
  Future<List<MovieEntity>> getPopular() async {
    // TODO: implement getPopular
    try {
      final movies = await remoteDataSource.getPopular();
      return movies;
    } catch (e) {
      throw List<MovieEntity>;
    }
  }
}
