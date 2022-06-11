import 'dart:io';
import 'dart:math';

import 'package:wavie/data/data_sources/movie_remote_data_source.dart';
import 'package:wavie/data/models/movie_model.dart';
import 'package:wavie/domain/entities/app_error.dart';
import 'package:wavie/domain/entities/movie_detail_entity.dart';
import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/domain/entities/movie_search_params.dart';
import 'package:wavie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MovieModel>> getTrending() async {
    // TODO: implement getTrending
    try {
      final movies = await remoteDataSource.getTrending();
      //(movies);
      return movies;
    } on SocketException {
      //print('socket2');
      return Future.error(AppErrorType.networkError);
    } on Exception {
      //print('api');
      return Future.error(AppErrorType.apiError);
    }
  }

  @override
  Future<List<MovieEntity>> getTop10() async {
    // TODO: implement getTop10
    try {
      final movies = await remoteDataSource.getTop10();
      return movies;
    } on SocketException {
      return Future.error(AppErrorType.networkError);
    } on Exception {
      return Future.error(AppErrorType.networkError);
    }
  }

  @override
  Future<List<MovieEntity>> getPopular() async {
    // TODO: implement getPopular
    try {
      final movies = await remoteDataSource.getPopular();
      return movies;
    } on SocketException {
      return Future.error(AppErrorType.networkError);
    } on Exception {
      return Future.error(AppErrorType.networkError);
    }
  }

  @override
  Future<MovieDetailEntity> getMovieDetail(int movieId) async {
    // TODO: implement getMovieDetail
    try {
      final movies = await remoteDataSource.getMovieDetail(movieId);
      return movies;
    } on SocketException {
      return Future.error(AppErrorType.networkError);
    } on Exception {
      return Future.error(AppErrorType.networkError);
    }
  }

  @override
  Future<List<MovieModel>> getSearchedMovie(String query) async {
    // TODO: implement getSearchedMovie
    try {
      final movies = await remoteDataSource.getSearchedMovie(query);
      return movies;
    } on SocketException {
      return Future.error(AppErrorType.networkError);
    } on Exception {
      return Future.error(AppErrorType.networkError);
    }
  }
}
