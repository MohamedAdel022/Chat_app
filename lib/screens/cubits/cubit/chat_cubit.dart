import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/models/messages_model.dart';
import 'package:scholar_chat/services/time.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  Future<void> sendMessage(
      {required String message, required String emailAddress}) async {
    try {
      messages.add({
        'text': message,
        'createdAt': await TimeService().fetchCurrentTime(),
        'email': emailAddress,
      });
    } on Exception catch (e) {
      // TODO
    }
  }

  void getMessages() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<MessagesModel> messages = [];
      for (var doc in event.docs) {
        messages.add(MessagesModel.fromJson(doc));
      }
      log("done");
      emit(ChatSuccess(messages));
    });
  }
}
