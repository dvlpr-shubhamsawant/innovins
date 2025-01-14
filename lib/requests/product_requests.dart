import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:innovins_tech/models/product_data_model.dart';

class ProductRequests {
  ProductRequests.internal();
  static ProductRequests _instance = ProductRequests.internal();
  factory ProductRequests() => _instance;
  String baseUrl = "https://shareittofriends.com/demo/flutter";

  Future<List<ProductDataModel>?> getProductsApi(data) async {
    Uri url = Uri.parse(baseUrl + '/productList.php');
    try {
      http.Response res = await http.post(url, body: data);
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        List<ProductDataModel> products =
            data.map((product) => ProductDataModel.fromJson(product)).toList();
        return products;
      } else {
        log(res.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<http.Response?> addProductRequest(data) async {
    Uri url = Uri.parse(baseUrl + '/addProduct.php');
    try {
      http.Response res = await http.post(url, body: data);
      if (res.statusCode == 200) {
        return res;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<http.Response?> editProductRequest(data) async {
    Uri url = Uri.parse(baseUrl + '/editProduct.php');
    try {
      http.Response res = await http.post(url, body: data);
      if (res.statusCode == 200) {
        return res;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<http.Response?> deleteProductRequest({id, token}) async {
    Uri url = Uri.parse(baseUrl + '/deleteProduct.php');
    try {
      http.Response res =
          await http.post(url, body: {"user_login_token": token, "id": id});
      if (res.statusCode == 200) {
        return res;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
