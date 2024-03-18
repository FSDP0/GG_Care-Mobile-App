import "package:flutter/material.dart";
import "package:gg_care/auth/utils/submit.utils.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _userId;
  String? _userPwd;

  final TextEditingController _userId_co = TextEditingController();
  final TextEditingController _userPwd_co = TextEditingController();

  final API = HttpAPI();

  @override
  void initState() {
    super.initState();
    _userId = "";
    _userPwd = "";
  }

  @override
  void dispose() {
    super.dispose();

    _userId_co.dispose();
    _userPwd_co.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return WillPopScope(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 120, left: 10, right: 10),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: <Widget>[
                _header(),
                _IdField(),
                _PwdField(),
                _LoginBtn(ctx),
                _FindBtn(),
                _footer()
              ],
            ),
          ),
        ),
        onWillPop: () {
          return _willPopCallback();
        });
  }

  Widget _header() => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: const Text(
          "건.전 Care",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
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

  Widget _LoginBtn(ctx) => Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(10),
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _userId = _userId_co.text;
              _userPwd = _userPwd_co.text;
            });

            API.LoginAPI(ctx, {"_Id": _userId, "_Pwd": _userPwd});
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
          ),
        ),
      );

  Widget _FindBtn() => TextButton(
        onPressed: () {
          setState(() {
            _userId = _userId_co.text;
            _userPwd = _userPwd_co.text;
          });
        },
        child: const Text("Forgot Password"),
      );

  Widget _footer() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("계정이 없나요?"),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/regist");
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          )
        ],
      );

  Future<bool> _willPopCallback() async {
    return Future.value(true);
  }
}
