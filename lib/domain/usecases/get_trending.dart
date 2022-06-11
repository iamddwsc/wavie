import 'package:wavie/domain/entities/movie_entity.dart';
import 'package:wavie/domain/entities/no_params.dart';
import 'package:wavie/domain/repositories/movie_repository.dart';
import 'package:wavie/domain/usecases/usecase.dart';

class GetTrending extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetTrending(this.repository);

  @override
  Future<List<MovieEntity>> call(NoParams params) async {
    //('call');
    return await repository.getTrending();
  }
}
