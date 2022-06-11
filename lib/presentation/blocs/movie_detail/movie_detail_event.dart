part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class MovieDetailLoadEvent extends MovieDetailEvent {
  final int movieId;

  const MovieDetailLoadEvent(this.movieId);

  @override
  // TODO: implement props
  List<Object?> get props => [movieId];
}
