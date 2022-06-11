import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:wavie/data/core/api_client.dart';
import 'package:wavie/data/data_sources/movie_remote_data_source.dart';
import 'package:wavie/data/data_sources/movie_remote_data_source_impl.dart';
import 'package:wavie/data/repositories/movie_repository_impl.dart';
import 'package:wavie/domain/repositories/movie_repository.dart';
import 'package:wavie/domain/usecases/get_movie_detail.dart';
import 'package:wavie/domain/usecases/get_trending.dart';
import 'package:wavie/domain/usecases/search_movies.dart';
import 'package:wavie/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:wavie/presentation/blocs/movie_detail/movie_detail_bloc.dart';

import '../presentation/blocs/search_movie/bloc/search_movie_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  /// All dependencies goes here
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance()));
  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));
  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));

  getItInstance
      .registerFactory(() => MovieCarouselBloc(getTrending: getItInstance()));
  getItInstance
      .registerFactory(() => MovieDetailBloc(getMovieDetail: getItInstance()));
  getItInstance
      .registerFactory(() => SearchMovieBloc(searchMovies: getItInstance()));
}
