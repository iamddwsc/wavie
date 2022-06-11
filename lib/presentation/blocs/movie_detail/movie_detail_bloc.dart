import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wavie/domain/entities/app_error.dart';
import 'package:wavie/domain/entities/movie_detail_entity.dart';
import 'package:wavie/domain/entities/movie_params.dart';
import 'package:wavie/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  MovieDetailBloc({required this.getMovieDetail})
      : super(MovieDetailInitial()) {
    on<MovieDetailEvent>((event, emit) async {
      // TODO: implement event handler

      try {
        if (event is MovieDetailLoadEvent) {
          final movie = await getMovieDetail(MovieParams(event.movieId));
          emit(MovieDetailLoaded(movieDetailEntity: movie));
        }
      } catch (e) {
        emit(MovieDetailError(e as AppErrorType));
      }
    });
  }
}
