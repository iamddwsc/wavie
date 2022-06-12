import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wavie/data/models/user.dart';
import 'package:wavie/domain/entities/app_error.dart';
import 'package:wavie/domain/entities/sign_in_params.dart';
import 'package:wavie/domain/usecases/sign_in.dart';
import 'package:wavie/domain/usecases/update_user.dart';

import '../../../domain/entities/update_params.dart';
import '../../../domain/usecases/sign_out.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignInUser signInUser;
  final SignOutUser signOutUser;
  final UpdateUser updateUser;
  AuthenticationBloc(
      {required this.signInUser,
      required this.signOutUser,
      required this.updateUser})
      : super(SignInInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        if (event is SignInEvent) {
          final response = await signInUser.call(SignInRequestParams(
              userName: event.username, password: event.password));
          emit(SignInSuccess(response));
        } else if (event is SignOutEvent) {
          await signOutUser(event.token);
          emit(SignOutSuccess());
        } else if (event is UpdateUserEvent) {
          final response = await updateUser.call(UpdateUserParams(
              last_name: event.last_name,
              first_name: event.first_name,
              filepath: event.filepath,
              token: event.token));
          emit(UpdateUserSuccess(response));
        }
      } catch (e) {
        //var message = getErrorMessage(e as AppErrorType);
        print(e);
        // emit(SignInError(message));
        //print(e);
      }
    });
  }

  String getErrorMessage(AppErrorType error) {
    switch (error) {
      case AppErrorType.apiError:
        return 'Wrong in Api';
      case AppErrorType.networkError:
        return 'Network Error';
      case AppErrorType.unauthorisedError:
        return 'Unauthorised Error';
      default:
        return 'Wrong username or password';
    }
  }
}
