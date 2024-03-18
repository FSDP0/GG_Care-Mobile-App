import "package:flutter/material.dart";

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _drawerFlag = true;

  @override
  void initState() {
    super.initState();
  }

  void toggleSwitch(bool val) {
    if (_drawerFlag == false) {
      setState(() {
        _drawerFlag = true;
      });
    } else {
      setState(() {
        _drawerFlag = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                Navigator.pop(context, _drawerFlag);
              },
            ),
            title: const Text("건.전 Care"),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Toggle Drawer"),
                    Switch(
                      value: _drawerFlag,
                      onChanged: toggleSwitch,
                      activeColor: Colors.deepPurple,
                      inactiveThumbColor: Colors.grey,
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white,
                    )
                  ],
                ),
              )
            ],
          )),
      onWillPop: () {
        return _willPipCallback();
      },
    );
  }

  Future<bool> _willPipCallback() async {
    return Future.value(true);
  }
}
