import 'dart:async';

import "package:flutter/material.dart";

import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";

import 'package:gg_care/auth/pages/login.page.dart';
import 'package:gg_care/auth/pages/mod.page.dart';
import 'package:gg_care/auth/pages/reg.page.dart';

import 'package:gg_care/common/pages/home.page.dart';
import 'package:gg_care/common/pages/about.page.dart';
import 'package:gg_care/common/pages/setting.page.dart';

import 'package:gg_care/fcm/pages/fcmView.page.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";

Future<void> _firebaseMsgBackgroundHandler(RemoteMessage msg) async {
  await Firebase.initializeApp();

  print("Handling a background message ${msg.messageId}");
}

Future<void> main() async {
  await dotenv.load(fileName: 'assets/config/.env');

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMsgBackgroundHandler);

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: "FCM Messaging Service",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: <String, WidgetBuilder>{
        "/home": (ctx) => const Home(),
        "/message": (ctx) => const MsgView(),
        "/regist": (ctx) => const RegistPage(),
        "/update": (ctx) => const ModifyPage(),
        "/login": (ctx) => const LoginPage(),
        "/about": (ctx) => const AboutPage(),
        "/setting": (ctx) => const SettingPage()
      },
    );
  }
}
