import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innovins_tech/const/enum.dart';
import 'package:innovins_tech/const/name_const.dart';
import 'package:innovins_tech/models/auth_user_model.dart';
import 'package:innovins_tech/requests/auth_requests.dart';
import 'package:innovins_tech/services/hive_service.dart';
import 'package:innovins_tech/views/splash_screen/splash_screen.dart';

class AuthController extends ChangeNotifier {
  AuthUserModel? newUser = AuthUserModel();
  AuthUserModel? user = AuthUserModel();
  bool authLoading = false;

  set updateAuthLoading(bool value) {
    authLoading = value;
    notifyListeners();
  }

  Future registerUser(Map<String, dynamic> userData) async {
    updateAuthLoading = true;
    newUser = await AuthRequests().userRegisterRequest(userData);
    if (newUser?.data?.userToken == null) {
      updateAuthLoading = false;
      return false;
    } else {
      updateAuthLoading = false;
      return true;
    }
  }

  Future signinUser(Map<String, dynamic> userData) async {
    updateAuthLoading = true;
    user = await AuthRequests().userLoginRequest(userData);
    if (user?.data?.userToken == null) {
      updateAuthLoading = false;
      return false;
    } else {
      updateAuthLoading = false;
      return true;
    }
  }

  Future signOut(context) async {
    await HiveService().deleteToken(NameConst.key);
    GoRouter.of(context).goNamed(SplashScreen.id);
  }
}
