import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:path/path.dart";
import "package:http/http.dart" as http;
import "package:flutter_dotenv/flutter_dotenv.dart";

class HttpAPI {
  final String? _Url = dotenv.env["WAS_SERVER_URI"];

  HttpAPI();

  void RegAPI(
    context,
    Map<String, dynamic> userInfo,
  ) async {
    var RegUrl = Uri.parse(join("$_Url", "auth", "regist"));

    var res = await http.post(RegUrl, body: {
      "userId": userInfo["_Id"],
      "userEmail": userInfo["_Email"],
      "userPassword": userInfo["_Pwd"],
      "userName": userInfo["_Name"],
    });

    if (res.statusCode == 201) {
      print("Regist Ok");
      //
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   "/login",
      //       (route) => false,
      //   arguments: {
      //     "userId": userInfo["_Id"],
      //     "userPassword": userInfo["_Pwd"],
      //   },
      // ).then((value) {
      //   print("Login OK");
      // });

      Navigator.pushReplacementNamed(context, "/login");
    } else {
      print(res.statusCode);
    }
  }

  void LoginAPI(
    context,
    Map<String, dynamic> userInfo,
  ) async {
    var LoginUrl = Uri.parse(join("$_Url", "auth", "Login"));

    var res = await http.post(
      LoginUrl,
      body: {
        "userId": userInfo["_Id"],
        "userPassword": userInfo["_Pwd"],
      },
    );
    print(res.statusCode);

    if (res.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/home",
        (route) => false,
        arguments: {
          "userId": userInfo["_Id"],
          "userPassword": userInfo["_Pwd"],
        },
      ).then((value) {
        print("Login OK");
      });
    } else {
      print(res.statusCode);
    }
  }

  void UpdateAPI(
    context,
    Map<String, dynamic> userInfo,
  ) async {
    var UpdateUrl = Uri.parse(join("$_Url", "auth", "Update"));

    var res = await http.patch(UpdateUrl, body: {
      "userId": userInfo["_Id"],
      "userEmail": userInfo["_Email"],
      "userPassword": userInfo["_Pwd"],
      "userName": userInfo["_Name"],
    });

    if (res.statusCode == 200) {
      print("Update Ok");

      Navigator.pop(context);
    } else {
      print(res.statusCode);
    }
  }

  void LogoutAPI(context) async {
    var LogoutUrl = Uri.parse(join("$_Url", "auth", "Logout"));

    var res = await http.get(LogoutUrl);

    if (res.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/login",
        (route) => false,
      ).then((value) {
        print("Logout OK");
      });
    } else {
      print(res.statusCode);
    }
  }

  void DelAPI(context) async {
    var DelUrl = Uri.parse(join("$_Url", "auth", "Delete"));

    var res = await http.delete(DelUrl);

    if (res.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/login",
        (route) => false,
      ).then((value) {
        print("Delete User Info Successfully");
      });
    } else {
      print(res.statusCode);
    }
  }
}
