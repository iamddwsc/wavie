part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final AppErrorType errorType;

  const MovieDetailError(this.errorType);

  @override
  List<Object> get props => [errorType];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailEntity movieDetailEntity;

  const MovieDetailLoaded({required this.movieDetailEntity});

  @override
  // TODO: implement props
  List<Object> get props => [movieDetailEntity];
}
