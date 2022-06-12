part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthenticationEvent {
  final String username, password;

  SignInEvent(this.username, this.password);

  @override
  // TODO: implement props
  List<Object> get props => [username, password];
}

class SignOutEvent extends AuthenticationEvent {
  final String token;

  SignOutEvent(this.token);

  @override
  // TODO: implement props
  List<Object> get props => [token];
}

class UpdateUserEvent extends AuthenticationEvent {
  final String last_name, first_name, filepath, token;

  UpdateUserEvent(this.last_name, this.first_name, this.filepath, this.token);

  @override
  // TODO: implement props
  List<Object> get props => [last_name, first_name, filepath, token];
}
