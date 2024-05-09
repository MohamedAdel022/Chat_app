import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/messages_model.dart';

class ChatBubleSender extends StatelessWidget {
  ChatBubleSender({
    required this.message,
    Key? key,
  }) : super(key: key);
  final MessagesModel message;

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      constraints: BoxConstraints(maxWidth: 250.0, minWidth: 70),
      tail: true,
      text: message.message +
          " " +
          message.createdAt.hour.toString() +
          ':' +
          message.createdAt.minute.toString() +
          ' ',
      color: kPrimaryColor,
      textStyle: TextStyle(color: Colors.white, fontSize: 16),
      isSender: true,
    );
  }
}

class ChatBubleReciver extends StatelessWidget {
  ChatBubleReciver({
    required this.message,
    Key? key,
  }) : super(key: key);
  final MessagesModel message;

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      color: Color(0xff006488),
      constraints: BoxConstraints(maxWidth: 250.0, minWidth: 70),
      tail: true,
      text: message.createdAt.hour.toString() +
          ':' +
          message.createdAt.minute.toString() +
          ' ' +
          message.message,
      textStyle: TextStyle(color: Colors.white, fontSize: 16),
      isSender: false,
    );
  }
}
