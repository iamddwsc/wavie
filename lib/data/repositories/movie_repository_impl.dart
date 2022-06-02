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
      //print(movies[0].title);
      return movies;
    } catch (e) {}
    throw List<MovieEntity>;
  }
}
