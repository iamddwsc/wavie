import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:wavie/data/data_sources/movie_remote_data_source.dart';
import 'package:wavie/data/data_sources/movie_remote_data_source_impl.dart';
import 'package:wavie/data/repositories/movie_repository_impl.dart';
import 'package:wavie/domain/repositories/movie_repository.dart';
import 'package:wavie/domain/usecases/get_trending.dart';
import 'package:wavie/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  /// All dependencies goes here
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance()));

  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));

  getItInstance
      .registerFactory(() => MovieCarouselBloc(getTrending: getItInstance()));
}
