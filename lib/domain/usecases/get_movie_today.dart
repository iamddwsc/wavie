import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/domain/entities/no_params.dart';
import 'package:wavie/domain/repositories/movie_repository.dart';
import 'package:wavie/domain/usecases/usecase.dart';

class GetMovieToday extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetMovieToday(this.repository);

  @override
  Future<List<MovieEntity>> call(NoParams params) async {
    //('call');
    return await repository.getMovieToday();
  }
}
