part of 'register_cubit.dart';

abstract class RegisterState  {
  const RegisterState();

}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFaliure extends RegisterState {
  final String message;

  RegisterFaliure(this.message);
}



