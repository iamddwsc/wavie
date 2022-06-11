import 'package:equatable/equatable.dart';

class MovieParams extends Equatable {
  final int movieId;

  const MovieParams(this.movieId);

  @override
  // TODO: implement props
  List<Object?> get props => [movieId];
}
