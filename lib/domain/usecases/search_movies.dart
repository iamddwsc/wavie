import 'package:wavie/data/models/movie_model.dart';
import 'package:wavie/domain/entities/movie_detail_entity.dart';
import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/domain/entities/movie_params.dart';
import 'package:wavie/domain/entities/movie_search_params.dart';
import 'package:wavie/domain/entities/no_params.dart';
import 'package:wavie/domain/repositories/movie_repository.dart';
import 'package:wavie/domain/usecases/usecase.dart';

class SearchMovies extends UseCase<List<MovieEntity>, MovieSearchParams> {
  final MovieRepository repository;

  SearchMovies(this.repository);

  @override
  Future<List<MovieModel>> call(MovieSearchParams params) async {
    //print('call');
    return await repository.getSearchedMovie(params.query);
  }
}
