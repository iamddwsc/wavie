import 'package:wavie/data/models/user.dart';
import 'package:wavie/domain/repositories/authentication_repository.dart';
import 'package:wavie/domain/usecases/usecase.dart';

import '../entities/sign_in_params.dart';

class SignInUser extends UseCase<User, SignInRequestParams> {
  final AuthenticationRepository _authenticationRepository;

  SignInUser(this._authenticationRepository);

  @override
  Future<User> call(SignInRequestParams params) async {
    //print('zzz' + params.toJson().toString());
    return _authenticationRepository.signInUser(params.toJson());
  }
}
