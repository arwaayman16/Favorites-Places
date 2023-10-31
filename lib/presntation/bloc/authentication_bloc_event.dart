part of 'authentication_bloc_bloc.dart';

@immutable
sealed class AuthenticationBlocEvent {}

class AuthenticationSignUpEvent extends AuthenticationBlocEvent {
  final String email, password;

  AuthenticationSignUpEvent({required this.email, required this.password});
}

class AuthenticationSignInEvent extends AuthenticationBlocEvent {
  final String email, password;

  AuthenticationSignInEvent({required this.email, required this.password});
}

class AuthenticationSignOutEvent extends AuthenticationBlocEvent {}

class AuthenticationIsSignedInEvent extends AuthenticationBlocEvent{}
