part of 'movie_today_bloc.dart';

abstract class MovieTodayEvent extends Equatable {
  const MovieTodayEvent();

  @override
  List<Object> get props => [];
}

class MovieTodayLoadEvent extends MovieTodayEvent {
  final int defaultIndex;

  MovieTodayLoadEvent({this.defaultIndex = 0})
      : assert(defaultIndex >= 0, 'default index cannot be less than 0');

  @override
  // TODO: implement props
  List<Object> get props => [defaultIndex];
}
