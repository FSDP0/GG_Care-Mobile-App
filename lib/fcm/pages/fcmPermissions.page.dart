import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";

class Permissions extends StatefulWidget {
  const Permissions({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Permissions();
}

class _Permissions extends State<Permissions> {
  bool _req = false;
  bool _fetching = false;

  late NotificationSettings _settings;

  Future<void> requestPermissions() async {
    setState(() {
      _fetching = true;
    });

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    setState(() {
      _req = true;
      _fetching = false;
      _settings = settings;
    });
  }

  Future<void> checkPermissions() async {
    setState(() {
      _fetching = true;
    });

    NotificationSettings settings =
        await FirebaseMessaging.instance.getNotificationSettings();

    setState(() {
      _req = true;
      _fetching = false;
      _settings = settings;
    });
  }

  Widget row(String title, String val) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title : ",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(val)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) {
      return const CircularProgressIndicator();
    }

    if (!_req) {
      return ElevatedButton(
          onPressed: requestPermissions,
          child: const Text("Request Permissions"));
    }

    return Column(children: [
      row("Authorization Status ", statusMap[_settings.authorizationStatus]!),
      ElevatedButton(
          onPressed: checkPermissions, child: const Text("Reload Permissions"))
    ]);
  }
}

const statusMap = {
  AuthorizationStatus.authorized: "Authorized",
  AuthorizationStatus.denied: "Denied",
  AuthorizationStatus.notDetermined: "Not Determined",
  AuthorizationStatus.provisional: "Provisional"
};
