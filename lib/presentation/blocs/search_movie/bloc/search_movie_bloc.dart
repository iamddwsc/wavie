import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wavie/data/models/movie_model.dart';
import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/domain/entities/movie_search_params.dart';
import 'package:wavie/domain/usecases/search_movies.dart';

import '../../../../domain/entities/app_error.dart';
import '../../movie_detail/movie_detail_bloc.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;
  SearchMovieBloc({required this.searchMovies}) : super(SearchMovieInitial()) {
    on<SearchMovieEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        if (event is SearchTermChangedEvent) {
          if (event.searchTerm.length > 2) {
            emit(SearchMovieLoading());
            final List<MovieModel> movies =
                await searchMovies(MovieSearchParams(query: event.searchTerm));
            //print(movies);
            emit(SearchMovieLoaded(movies));
          }
        }
      } catch (e) {
        //print(e);
        emit(SearchMovieError(e as AppErrorType));
      }
    });
  }
}
