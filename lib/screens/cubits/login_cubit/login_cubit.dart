import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> signInUser(
      {required String emailAddress, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        emit(LoginFaliure('Invalid credentials'));
      } else {
        String message = e.message!
            .replaceAll(", malformed or has expired.", ".")
            .trim()
            .replaceAll("auth", "authentication");
        emit(LoginFaliure(message));
      }
    } catch (e) {
      emit(LoginFaliure(e.toString()));
    }
  }
}
