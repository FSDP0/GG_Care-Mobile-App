import "package:flutter/material.dart";
import "package:firebase_messaging/firebase_messaging.dart";

class MessageArguments {
  final RemoteMessage msg;

  final bool openedApplication;

  MessageArguments(this.msg, this.openedApplication);
}

class MsgView extends StatelessWidget {
  const MsgView({Key? key}) : super(key: key);

  Widget row(String title, String? val) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title : "),
          Expanded(child: Text(val ?? "N/A")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MessageArguments args =
        ModalRoute.of(context)!.settings.arguments! as MessageArguments;
    RemoteMessage msg = args.msg;
    RemoteNotification? notification = msg.notification;

    return Scaffold(
      appBar: AppBar(
        title: Text(msg.data['title'] ?? "N/A"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              row("Message Id", msg.from),
              row("Sender Id", msg.senderId),
              row("Category Id", msg.category),
              // row("Data", msg.data.toString()),
              // row("Title", msg.notification?.title),
              // row("Data", msg.data.toString()),
              // row("Title", msg.data['title']),
              row("Body", msg.data['body']),
              row("Sent Time", msg.sentTime.toString()),
              // if (notification?.android != null) ...[
              //   const SizedBox(height: 16)
              //   const Text("data"))
              // ]
            ],
          ),
        ),
      ),
    );
  }
}
