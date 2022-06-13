import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/entities/no_params.dart';
import '../../../domain/usecases/get_movie_today.dart';
import '../movie_carousel/movie_carousel_bloc.dart';

part 'movie_today_event.dart';
part 'movie_today_state.dart';

class MovieTodayBloc extends Bloc<MovieTodayEvent, MovieTodayState> {
  final GetMovieToday getMovieToday;
  MovieTodayBloc({required this.getMovieToday}) : super(MovieTodayInitial()) {
    on<MovieTodayEvent>((event, emit) async {
      try {
        if (event is MovieTodayLoadEvent) {
          final movies = await getMovieToday(NoParams());
          emit(MovieTodayLoaded(
              movies: movies, defaultIndex: event.defaultIndex));
        }
      } catch (e) {
        print(e);
        emit(MovieTodayError(e as AppErrorType));
        //emit(MovieCarouselError(AppErrorType.apiError));
      }
    });
  }
}
