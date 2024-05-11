import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    debugPrint("Change= ${change.toString()}");
  }

  @override
  void onClose(BlocBase bloc) {
    // TODO: implement onClose
    debugPrint("Close= ${bloc.toString()}");
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint("Create= $bloc");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
  }
}
