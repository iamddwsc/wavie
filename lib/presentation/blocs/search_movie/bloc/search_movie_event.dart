part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchTermChangedEvent extends SearchMovieEvent {
  final String searchTerm;

  SearchTermChangedEvent(this.searchTerm);

  @override
  // TODO: implement props
  List<Object> get props => [searchTerm];
}
