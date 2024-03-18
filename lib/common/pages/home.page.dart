import 'dart:io';
import "package:image_picker/image_picker.dart";

import "package:flutter/material.dart";

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:gg_care/auth/controller/del.controller.dart';
import 'package:gg_care/auth/controller/logout.controller.dart';

import 'package:gg_care/fcm/pages/fcmPermissions.page.dart';
import 'package:gg_care/fcm/pages/fcmView.page.dart';
import 'package:gg_care/fcm/pages/fcmList.page.dart';

import "package:gg_care/fcm/utils/metaCard.utils.dart";
import "package:gg_care/fcm/utils/tokenMonitor.utils.dart";

// Notification
import "package:flutter/material.dart";
import "package:flutter_app_badger/flutter_app_badger.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:flutter_native_timezone/flutter_native_timezone.dart";
import "package:timezone/data/latest_all.dart" as tz;
import "package:timezone/timezone.dart" as tz;

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? _token;
  bool _alarmFlag = true;
  bool _drawerFlag = true;

  // final ImagePicker _pricker = ImagePicker();

  PickedFile? _image;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? msg) {
      if (msg != null) {
        Navigator.pushNamed(
          context,
          "/message",
          arguments: MessageArguments(msg, true),
        );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print("Got a message whilst in the foreground!");
      print("Message Data : ${msg.data}");

      if (msg.notification != null) {
        print("Message also contained a notification : ${msg.notification}");
      }

      RemoteNotification? notification = msg.notification;
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      print("A new onMessageOpenedApp event was published");

      Navigator.pushNamed(
        context,
        "/message",
        arguments: MessageArguments(msg, true),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // SystemNavigator.pop();

        return _willPopCallback();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.cloud,
            color: Colors.white,
          ),
          title: const Text(
            "건.전 Care",
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              // const MetaCard("Permissions", Permissions()),
              // MetaCard("FCM Token", TokenMonitor((token) {
              //   _token = token;
              //   return token == null
              //       ? const CircularProgressIndicator()
              //       : Text(token, style: const TextStyle(fontSize: 12));
              // })),
              MetaCard("Message Stream", MsgList()),
              // Container(
              //   margin: const EdgeInsets.only(top: 20),
              //   child: OutlinedButton(
              //     onPressed: () {
              //       print("Notification On");
              //       setState(() {
              //         _alarmFlag = !_alarmFlag;
              //       });
              //     },
              //     child: _alarmFlag
              //         ? const Icon(
              //             Icons.notifications,
              //             color: Colors.black,
              //             size: 150,
              //           )
              //         : const Icon(
              //             Icons.notifications_off,
              //             color: Colors.black,
              //             size: 150,
              //           ),
              //     style: OutlinedButton.styleFrom(
              //       fixedSize: const Size(300, 300),
              //       backgroundColor: Colors.deepPurpleAccent,
              //       side:
              //           const BorderSide(width: 10.0, color: Colors.deepPurple),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(150),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        endDrawer: _drawerFlag
            ? Drawer(
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      // currentAccountPicture: CircleAvatar(
                      //   child: Icon(
                      //     Icons.person,
                      //     size: 30,
                      //   ),
                      //   backgroundColor: Colors.white,
                      // ),
                      currentAccountPicture: ElevatedButton(
                        onPressed: _getImage,
                        child: _image == null
                            ? const Icon(Icons.person)
                            : Image.file(File(_image!.path)),
                        style: ButtonStyle(
                            shape:
                                MaterialStateProperty.all(const CircleBorder()),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.red;
                                }
                              },
                            )),
                      ),
                      accountName: const Text("My Name"),
                      accountEmail: const Text("My Email"),
                      decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          border: Border()),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                        color: Colors.deepPurple,
                      ),
                      title: const Text("Home"),
                      onTap: () {
                        print("Home");
                        Navigator.pushReplacementNamed(context, "/",
                            arguments: _drawerFlag);
                      },
                    ),
                    ExpansionTile(
                      leading: const Icon(
                        Icons.message,
                        color: Colors.deepPurple,
                      ),
                      title: const Text("Message"),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                ListTile(
                                  leading: Icon(Icons.list),
                                  title: Text("List"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.list),
                                  title: Text("View"),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    ExpansionTile(
                      leading: const Icon(
                        Icons.manage_accounts_outlined,
                        color: Colors.deepPurple,
                      ),
                      title: const Text("Account"),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.logout),
                                  title: const Text("Logout"),
                                  onTap: () {
                                    logoutUser(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.delete),
                                  title: const Text("Delete"),
                                  onTap: () {
                                    delUser(context); //
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: Colors.deepPurple,
                      ),
                      title: const Text("Settings"),
                      onTap: () {
                        print("Setting");
                        Navigator.pushReplacementNamed(context, "/setting");
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.question_mark,
                        color: Colors.deepPurple,
                      ),
                      title: const Text("About"),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/about");
                      },
                    )
                  ],
                ),
              )
            : Container(),
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    return Future.value(true);
  }

  Future _getImage() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }
}
