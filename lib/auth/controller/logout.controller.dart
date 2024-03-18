import 'package:flutter/cupertino.dart';
import "package:gg_care/auth/utils/submit.utils.dart";

void logoutUser(ctx) {
  final API = HttpAPI();

  API.LogoutAPI(ctx);

  Navigator.pushNamed(ctx, "/login");
}
