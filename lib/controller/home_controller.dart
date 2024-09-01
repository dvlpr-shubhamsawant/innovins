import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:innovins_tech/const/enum.dart';
import 'package:innovins_tech/models/product_data_model.dart';
import 'package:innovins_tech/requests/product_requests.dart';

class HomeController extends ChangeNotifier {
  int selectedIndex = 0;
  ProductRequests productRequests = ProductRequests();
  List<ProductDataModel>? products = [];
  bool isProductLoading = false;

  set updateProductLoading(bool update) {
    isProductLoading = update;
    notifyListeners();
  }

  set UpdateSelectionIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  Future<void> fetchAllProducts(token) async {
    updateProductLoading = true;
    products = await productRequests.getProductsApi(
      {'user_login_token': token},
    );
    updateProductLoading = false;
  }

  Future<Status> addProduct(data, token) async {
    updateProductLoading = true;
    var res = await productRequests.addProductRequest(data);
    if (res != null) {
      if (res.statusCode == 200) {
        updateProductLoading = false;
        return Status.success;
      } else {
        updateProductLoading = false;
        return Status.failure;
      }
    }
    updateProductLoading = false;
    notifyListeners();
    return Status.failure;
  }

  Future<Status> editProduct(data, token) async {
    updateProductLoading = true;
    var res = await productRequests.editProductRequest(data);
    if (res != null) {
      if (res.statusCode == 200) {
        updateProductLoading = false;
        return Status.success;
      } else {
        updateProductLoading = false;
        return Status.failure;
      }
    }
    updateProductLoading = false;
    notifyListeners();
    return Status.failure;
  }

  Future<Status?> deleteProduct({id, token}) async {
    updateProductLoading = true;
    var res = await productRequests.deleteProductRequest(id: id, token: token);
    if (res != null) {
      if (res.statusCode == 200) {
        updateProductLoading = false;
        return Status.success;
      } else {
        updateProductLoading = false;
        return Status.failure;
      }
    }
    updateProductLoading = false;
    return null;
  }
}
