import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MssageBar extends StatelessWidget {
  MssageBar({required this.onSend});
  final Function(String)? onSend;
  @override
  Widget build(BuildContext context) {
    return MessageBar(
      onSend: onSend,
      sendButtonColor: kPrimaryColor,
    );
  }
}
