import 'package:flutter/cupertino.dart';
import "package:gg_care/auth/utils/submit.utils.dart";

void delUser(ctx) async {
  final API = HttpAPI();

  API.DelAPI(ctx);

  Navigator.pushNamed(ctx, "/login");
}
