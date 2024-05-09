part of 'chat_cubit.dart';

sealed class ChatState {
  const ChatState();


}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  final List<MessagesModel> messages;

  ChatSuccess(this.messages);
}
