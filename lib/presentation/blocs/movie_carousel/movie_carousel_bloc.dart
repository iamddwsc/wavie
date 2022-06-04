import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/domain/entities/no_params.dart';
import 'package:wavie/domain/usecases/get_trending.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;

  MovieCarouselBloc({required this.getTrending})
      : super(MovieCarouselInitial()) {
    on<CarouselLoadEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is CarouselLoadEvent) {
        final movies = await getTrending(NoParams());
        emit(MovieCarouselLoaded(
            movies: movies, defaultIndex: event.defaultIndex));
      }
    });
  }
}
