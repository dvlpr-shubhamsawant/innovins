import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:innovins_tech/models/product_data_model.dart';
import 'package:innovins_tech/requests/product_requests.dart';

class HomeController extends ChangeNotifier {
  int selectedIndex = 0;
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

  Future<void> fetchAllProducts(key) async {
    updateProductLoading = true;
    products = await ProductRequests().getProductsApi(
      {'user_login_token': key},
    );
    log(products.toString());
  }
}
