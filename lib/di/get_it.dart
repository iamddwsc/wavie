import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:wavie/data/core/api_client.dart';
import 'package:wavie/data/data_sources/authentication_remote_data_source.dart';
import 'package:wavie/data/data_sources/movie_remote_data_source.dart';
import 'package:wavie/data/data_sources/movie_remote_data_source_impl.dart';
import 'package:wavie/data/repositories/movie_repository_impl.dart';
import 'package:wavie/domain/repositories/movie_repository.dart';
import 'package:wavie/domain/usecases/get_movie_detail.dart';
import 'package:wavie/domain/usecases/get_trending.dart';
import 'package:wavie/domain/usecases/search_movies.dart';
import 'package:wavie/domain/usecases/sign_out.dart';
import 'package:wavie/domain/usecases/update_user.dart';
import 'package:wavie/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:wavie/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:wavie/presentation/blocs/movie_detail/movie_detail_bloc.dart';

import '../data/data_sources/authentication_local_data_source.dart';
import '../data/repositories/authentication_repository_impl.dart';
import '../domain/repositories/authentication_repository.dart';
import '../domain/usecases/sign_in.dart';
import '../presentation/blocs/search_movie/bloc/search_movie_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  /// All dependencies goes here
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance()));
  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));
  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));
  getItInstance
      .registerLazySingleton<SignInUser>(() => SignInUser(getItInstance()));
  getItInstance
      .registerLazySingleton<SignOutUser>(() => SignOutUser(getItInstance()));
  getItInstance
      .registerLazySingleton<UpdateUser>(() => UpdateUser(getItInstance()));
  //  getItInstance
  //     .registerLazySingleton<>(() => LogoutUser(getItInstance()));

  getItInstance.registerFactory(() => AuthenticationBloc(
      signInUser: getItInstance(),
      signOutUser: getItInstance(),
      updateUser: getItInstance()));
  getItInstance
      .registerFactory(() => MovieCarouselBloc(getTrending: getItInstance()));
  getItInstance
      .registerFactory(() => MovieDetailBloc(getMovieDetail: getItInstance()));
  getItInstance
      .registerFactory(() => SearchMovieBloc(searchMovies: getItInstance()));

  // getItInstance
  //     .registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
  //           getItInstance(),
  //           // getItInstance(),
  //         ));
  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));
}
