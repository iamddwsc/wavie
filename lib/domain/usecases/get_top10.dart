import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/domain/entities/no_params.dart';
import 'package:wavie/domain/repositories/movie_repository.dart';
import 'package:wavie/domain/usecases/usecase.dart';

class GetTop10 extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetTop10(this.repository);

  @override
  Future<List<MovieEntity>> call(NoParams params) async {
    // TODO: implement call
    return await repository.getTop10();
    ;
  }
}
