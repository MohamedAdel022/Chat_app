import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/messages_model.dart';
import 'package:scholar_chat/services/time.dart';
import 'package:scholar_chat/widgets/chat_buble.dart';
import 'package:scholar_chat/widgets/message_bare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessagesModel> mssages = [];
            for (var doc in snapshot.data!.docs) {
              mssages.add(MessagesModel.fromJson(doc));
            }
            mssages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            for (var message in mssages) {
              print(message.message);
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                automaticallyImplyLeading:
                    false, // Added to center the title/icon
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
                    child: ListView.builder(
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
                    ),
                  ),
                  MssageBar(onSend: (value) async {
                    messages.add({
                      'text': value,
                      'createdAt': await TimeService().fetchCurrentTime(),
                      'email': email,
                    });
                    controller.animateTo(
                      0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
