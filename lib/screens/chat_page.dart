import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/messages_model.dart';
import 'package:scholar_chat/screens/cubits/cubit/chat_cubit.dart';
import 'package:scholar_chat/widgets/chat_buble.dart';
import 'package:scholar_chat/widgets/message_bare.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  List<MessagesModel> mssages = [];
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false, // Added to center the title/icon
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(klogo, height: 40, width: 40),
            Text("chat"),
          ],
        ),
        // Replace with the desired icon
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  mssages = state.messages;
                  log(mssages.toString());
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: controller,
                  itemCount: mssages.length,
                  itemBuilder: (context, index) {
                    return mssages[index].email == email
                        ? GestureDetector(
                            onForcePressEnd: (details) {
                              print('long press');
                            },
                            child: ChatBubleSender(
                              // Replace with the desired widget
                              message: mssages[index],
                            ),
                          )
                        : ChatBubleReciver(message: mssages[index]);
                  },
                );
              },
            ),
          ),
          MssageBar(onSend: (value) {
            BlocProvider.of<ChatCubit>(context).sendMessage(
              message: value,
              emailAddress: email,
            );
            controller.animateTo(
              0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }),
        ],
      ),
    );
  }
}
