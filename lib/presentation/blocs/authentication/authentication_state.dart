part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends AuthenticationState {}

class SignInSuccess extends AuthenticationState {
  final User user;

  SignInSuccess(this.user);
  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class SignInError extends AuthenticationState {
  final String message;

  SignInError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class SignOutSuccess extends AuthenticationState {}

class UpdateUserSuccess extends AuthenticationState {
  final User user;

  UpdateUserSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class UpdateUserError extends AuthenticationState {
  final String message;

  UpdateUserError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
