part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFaliure extends LoginState {
  final String message;
  LoginFaliure(this.message);
}
