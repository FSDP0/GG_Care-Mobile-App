import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplasgPageState();
}

class _SplasgPageState extends State<SplashPage> {
  @override
  void initState() {
    // Timer(
    //   const Duration(milliseconds: 1500),
    //   () {
    //     Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    //   },
    // );
    super.initState();
    initialization();
  }

  void initialization() async {
    print("Ready in 3...");
    await Future.delayed(const Duration(seconds: 1));

    print("Ready in 2...");
    await Future.delayed(const Duration(seconds: 1));

    print("Ready in 1...");
    await Future.delayed(const Duration(seconds: 1));

    print("Application Ready!");
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext ctx) {
    // final String imageLogoName = "assets/images/public/PurpleLogo.svg";

    final ScreenHeight = MediaQuery.of(ctx).size.height;
    final ScreenWidth = MediaQuery.of(ctx).size.width;

    return WillPopScope(
        onWillPop: () async => false,
        child: MediaQuery(
          data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            backgroundColor: Colors.red,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: ScreenHeight * 0.3843375,
                ),
                Container(
                    // child: SvgPicture.asset(
                    //   imageLogoName,
                    // ),
                    ),
                Expanded(
                  child: SizedBox(),
                ),
                Align(
                  child: Text(
                    "@ Copyright 2022, 건.전 CARE",
                    style: TextStyle(
                      fontSize: ScreenWidth * (14 / 360),
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(ctx).size.height * 0.0625,
                )
              ],
            ),
          ),
        ));
  }
}
