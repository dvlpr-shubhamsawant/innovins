import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:innovins_tech/const/name_const.dart';
import 'package:innovins_tech/main.dart';
import 'package:innovins_tech/models/auth_user_model.dart';
import 'package:innovins_tech/services/hive_service.dart';
import 'package:innovins_tech/views/shared_widget/toast.dart';

class AuthRequests {
  AuthRequests.internal();
  static AuthRequests _instance = AuthRequests.internal();
  factory AuthRequests() => _instance;

  String baseUrl = "https://shareittofriends.com/demo/flutter";

  Future<AuthUserModel?> userRegisterRequest(Map<String, dynamic> data) async {
    Uri url = Uri.parse(baseUrl + '/Register.php');
    try {
      http.Response response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        var data = AuthUserModel.fromJson(jsonDecode(response.body));
        await HiveService().storeData(NameConst.key, data.data!.userToken!);
        log(data.message.toString());
        return data;
      } else {
        log("User Already Exist");
        return null;
      }
    } catch (e) {
      log(e.toString(), name: "ERROR WITH REGISTER USER");
    }
    return null;
  }

  Future<AuthUserModel?> userLoginRequest(Map<String, dynamic> data) async {
    Uri url = Uri.parse(baseUrl + '/Login.php');
    try {
      http.Response response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        var data = AuthUserModel.fromJson(jsonDecode(response.body));
        await HiveService().storeData(NameConst.key, data.data!.userToken!);
        log(data.message!);
        return data;
      } else {
        log("Please Create New User! User Not Exists");
      }
    } catch (e) {
      log(e.toString(), name: "ERROR WITH LOGIN USER");
      flutterToast(navigatorKey.currentState!.context, e.toString());
    }
    return null;
  }
}
