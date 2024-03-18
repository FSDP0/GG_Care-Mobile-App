import 'dart:convert';

import "package:flutter/material.dart";
import "package:firebase_messaging/firebase_messaging.dart";

import 'package:gg_care/fcm/pages/fcmView.page.dart';

class MsgList extends StatefulWidget {
  const MsgList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MsgListState();
}

class _MsgListState extends State<MsgList> {
  List<RemoteMessage> _msg = [];

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      setState(() {
        _msg = [..._msg, msg];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_msg.isEmpty) {
      return const Text("No Messages Received");
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _msg.length,
      itemBuilder: ((context, index) {
        RemoteMessage msg = _msg[index];

        return ListTile(
            title:
                // Text(msg.messageId ?? "No RemoteMessage.messageId available"),
                // Text(msg.notification?.title ?? "Non Title"),
                // Text("Non"),
                Text(msg.data['title']),
            subtitle:
                Text(msg.sentTime?.toString() ?? DateTime.now().toString()),
            onTap: (() => Navigator.pushNamed(context, "/message",
                arguments: MessageArguments(msg, false))));
      }),
    );
  }
}
