import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:innovins_tech/const/app_colors.dart';
import 'package:innovins_tech/const/enum.dart';
import 'package:innovins_tech/const/spacing.dart';
import 'package:innovins_tech/controller/auth_controller.dart';
import 'package:innovins_tech/views/home.dart';
import 'package:innovins_tech/views/home_screen/home_screen.dart';
import 'package:innovins_tech/views/shared_widget/custom_textfield.dart';
import 'package:innovins_tech/views/shared_widget/toast.dart';
import 'package:innovins_tech/views/sign_in_screen/sign_in_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  static String id = "SignUpScreen";

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
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
                "Sign Up",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacing.heightBox(20),
              customTextFormField(label: "Name", controller: nameController),
              Spacing.heightBox(8),
              customTextFormField(
                  label: "Mobile Number", controller: mobileController),
              Spacing.heightBox(8),
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
                        "name": nameController.text,
                        "mobile": mobileController.text,
                        "email": emailController.text,
                        "password": passController.text,
                      };
                      await controller.registerUser(userData).then((value) {
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
                        : Text("Sign Up"),
                  ),
                );
              }),
              Spacing.heightBox(20),
              Divider(),
              Spacing.heightBox(20),
              GestureDetector(
                onTap: () => context.goNamed(SignInScreen.id),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColors.greyColor,
                    ),
                    children: [
                      TextSpan(
                        text: "Already Have an Account, ",
                      ),
                      TextSpan(
                        text: "Sign In!",
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
