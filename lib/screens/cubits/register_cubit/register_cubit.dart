import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser(
      {required String emailAddress, required String password}) async {
    emit(RegisterLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      print(credential.user!.email);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFaliure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFaliure('The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterFaliure('An error occurred'));

      debugPrint(e.toString());
    }
  }
}
