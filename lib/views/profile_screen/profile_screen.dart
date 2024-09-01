import 'package:flutter/material.dart';
import 'package:innovins_tech/controller/auth_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static String id = "ProfileScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
            onPressed: () async {
              var controller =
                  Provider.of<AuthController>(context, listen: false);
              await controller.signOut(context);
            },
            child: Text("Sign out")),
      ),
    );
  }
}
