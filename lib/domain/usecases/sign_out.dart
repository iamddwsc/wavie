import 'package:wavie/domain/usecases/usecase.dart';

import '../repositories/authentication_repository.dart';

class SignOutUser extends UseCase<void, String> {
  final AuthenticationRepository _authenticationRepository;

  SignOutUser(this._authenticationRepository);

  @override
  Future<String> call(String params) async {
    return _authenticationRepository.signOutUser(params);
  }
}
