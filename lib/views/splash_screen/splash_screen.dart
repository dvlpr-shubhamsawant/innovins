import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovins_tech/const/name_const.dart';
import 'package:innovins_tech/services/hive_service.dart';
import 'package:innovins_tech/views/home.dart';
import 'package:innovins_tech/views/sign_in_screen/sign_in_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static String id = "SplashScreen";

  changeScreen(context) async {
    Future.delayed(Duration.zero, () async {
      var token = await HiveService().getData(NameConst.key);
      log(token);
      if (token.isEmpty) {
        GoRouter.of(context).goNamed(SignInScreen.id);
      } else {
        GoRouter.of(context).goNamed(Home.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    changeScreen(context);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
