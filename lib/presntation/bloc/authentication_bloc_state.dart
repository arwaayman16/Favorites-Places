part of 'authentication_bloc_bloc.dart';

@immutable
sealed class AuthenticationBlocState {}

final class AuthenticationBlocInitial extends AuthenticationBlocState {}
final class AuthenticationBlocAuthorizedState extends AuthenticationBlocState {}

final class AuthenticationBlocNotAuthorizedState extends AuthenticationBlocState {}
final class AuthenticationBlocLoadingState extends AuthenticationBlocState {}
final class AuthenticationBlocErrorState extends AuthenticationBlocState {}




