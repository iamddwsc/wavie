import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_category_state.dart';

class MovieCategoryCubit extends Cubit<MovieCategoryState> {
  MovieCategoryCubit() : super(MovieCategoryInitial());
}
