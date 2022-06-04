import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/domain/entities/no_params.dart';
import 'package:wavie/domain/repositories/movie_repository.dart';
import 'package:wavie/domain/usecases/usecase.dart';

class GetPopular extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetPopular(this.repository);

  @override
  Future<List<MovieEntity>> call(NoParams params) async {
    return await repository.getPopular();
  }
}
