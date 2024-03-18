import 'package:flutter/material.dart';
import 'package:my_products/models/product.dart';

class cartItem extends ChangeNotifier {
  List<product> Products = [];
  Addproduct(product prod) {
    Products.add(prod);
    notifyListeners();
  }

  deleteProduct(product prod) {
    Products.remove(prod);
    notifyListeners();
  }
}
