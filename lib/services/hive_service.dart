import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:innovins_tech/const/enum.dart';
import 'package:innovins_tech/const/name_const.dart';

class HiveService {
  HiveService.internal();
  static HiveService _instance = HiveService.internal();
  factory HiveService() => _instance;

  Future<void> storeData(String key, String data) async {
    try {
      var box = await Hive.openBox(NameConst.authDB);
      await box.put(key, data);
      box.close();
    } catch (e) {
      log(e.toString(), name: "Added data failed");
    }
  }

  Future<String> getData(String key) async {
    try {
      var box = await Hive.openBox(NameConst.authDB);
      var data = await box.get(key);
      box.close();

      if (data == null) {
        return "";
      }
      log(data);
      return data;
    } catch (e) {
      log(e.toString(), name: "Get Data failed");
      return "";
    }
  }

  Future<void> deleteToken(String key) async {
    try {
      var box = await Hive.openBox(NameConst.authDB);
      await box.delete(key); // Remove the token from the box
      getData(key);
      box.close();
    } catch (e) {
      log(e.toString(), name: "Delete failed");
    }
  }
}
