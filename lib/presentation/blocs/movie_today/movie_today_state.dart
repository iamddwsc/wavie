part of 'movie_today_bloc.dart';

abstract class MovieTodayState extends Equatable {
  const MovieTodayState();

  @override
  List<Object> get props => [];
}

class MovieTodayInitial extends MovieTodayState {}

class MovieTodayLoaded extends MovieTodayState {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieTodayLoaded({required this.movies, this.defaultIndex = 0})
      : assert(defaultIndex >= 0, 'default index cannot be less than 0');

  @override
  // TODO: implement props
  List<Object> get props => [movies, defaultIndex];
}

class MovieTodayError extends MovieTodayState {
  final AppErrorType errorType;

  const MovieTodayError(this.errorType);
}
