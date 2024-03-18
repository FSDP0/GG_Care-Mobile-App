import "package:flutter/material.dart";
import 'package:gg_care/auth/utils/submit.utils.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  String? _userId;
  String? _userEmail;
  String? _userPwd;
  String? _userName;

  final TextEditingController _userId_co = TextEditingController();
  final TextEditingController _userEmail_co = TextEditingController();
  final TextEditingController _userPwd_co = TextEditingController();
  final TextEditingController _userName_co = TextEditingController();

  final API = HttpAPI();

  @override
  void initState() {
    super.initState();

    _userId = "";
    _userEmail = "";
    _userPwd = "";
    _userName = "";
  }

  @override
  void dispose() {
    super.dispose();

    _userId_co.dispose();
    _userEmail_co.dispose();
    _userPwd_co.dispose();
    _userName_co.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 120, left: 10, right: 10),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: <Widget>[
            _header(),
            _IdField(),
            _EmailField(),
            _PwdField(),
            _NameField(),
            _RegistBtn(ctx),
            _footer()
          ],
        ),
      ),
    );
  }

  Widget _header() => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: const Text(
          "건.전 Care",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
      );

  Widget _IdField() => Container(
        padding: const EdgeInsets.all(10),
        child: TextField(
          obscureText: false,
          controller: _userId_co,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Your ID",
          ),
        ),
      );

  Widget _EmailField() => Container(
        padding: const EdgeInsets.all(10),
        child: TextField(
          obscureText: false,
          controller: _userEmail_co,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Your Email",
          ),
        ),
      );

  Widget _PwdField() => Container(
        padding: const EdgeInsets.all(10),
        child: TextField(
          obscureText: true,
          controller: _userPwd_co,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Your Password",
          ),
        ),
      );

  Widget _NameField() => Container(
        padding: const EdgeInsets.all(10),
        child: TextField(
          obscureText: false,
          controller: _userName_co,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Your Name",
          ),
        ),
      );

  Widget _RegistBtn(ctx) => Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(10),
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            print("Regist Btn Clicked");

            setState(() {
              _userId = _userId_co.text;
              _userEmail = _userEmail_co.text;
              _userPwd = _userPwd_co.text;
              _userName = _userName_co.text;
            });

            API.RegAPI(ctx, {
              "_Id": _userId,
              "_Email": _userEmail,
              "_Pwd": _userPwd,
              "_Name": _userName,
            });
          },
          child: const Text("Sign Up"),
        ),
      );

  Widget _footer() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("계정이 있나요?"),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
            child: const Text(
              "Sing In",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      );
}
