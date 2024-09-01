import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovins_tech/const/app_colors.dart';
import 'package:innovins_tech/const/enum.dart';
import 'package:innovins_tech/const/spacing.dart';
import 'package:innovins_tech/controller/auth_controller.dart';
import 'package:innovins_tech/views/home.dart';
import 'package:innovins_tech/views/home_screen/home_screen.dart';
import 'package:innovins_tech/views/shared_widget/custom_textfield.dart';
import 'package:innovins_tech/views/shared_widget/toast.dart';
import 'package:innovins_tech/views/sign_up_screen/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  static String id = "SignInScreen";

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Spacing.screenPadding,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign In",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacing.heightBox(20),
              customTextFormField(label: "Email", controller: emailController),
              Spacing.heightBox(8),
              customTextFormField(
                  label: "Password", controller: passController),
              Spacing.heightBox(20),
              Consumer<AuthController>(builder: (context, controller, _) {
                return SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      Map<String, dynamic> userData = {
                        "email": emailController.text,
                        "password": passController.text,
                      };
                      await controller.signinUser(userData).then((value) {
                        log(value.toString());
                        if (value == Status.success) {
                          context.goNamed(Home.id);
                        } else {
                          flutterToast(context, "Something went wrong");
                        }
                      });
                    },
                    child: controller.authLoading == true
                        ? CircularProgressIndicator(
                            color: AppColors.whiteColor,
                            strokeWidth: 2,
                          )
                        : Text("Sign In"),
                  ),
                );
              }),
              Spacing.heightBox(20),
              Divider(),
              Spacing.heightBox(20),
              GestureDetector(
                onTap: () => context.goNamed(SignUpScreen.id),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColors.greyColor,
                    ),
                    children: [
                      TextSpan(
                        text: "Don't Have an account, ",
                      ),
                      TextSpan(
                        text: "Sign Up!",
                        style: TextStyle(color: AppColors.greenColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
