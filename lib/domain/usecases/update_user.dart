import 'package:wavie/domain/entities/update_params.dart';
import 'package:wavie/domain/usecases/usecase.dart';

import '../../data/models/user.dart';
import '../repositories/authentication_repository.dart';

class UpdateUser extends UseCase<User, UpdateUserParams> {
  final AuthenticationRepository _authenticationRepository;

  UpdateUser(this._authenticationRepository);

  @override
  Future<User> call(UpdateUserParams params) {
    // TODO: implement call
    return _authenticationRepository.updateUser(params.toJson());
  }
}
