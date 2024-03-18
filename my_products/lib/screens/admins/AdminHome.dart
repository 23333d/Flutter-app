import 'package:flutter/material.dart';
import 'package:my_products/screens/admins/AddProduct.dart';
import 'package:my_products/screens/admins/ManageProduct.dart';
import 'package:my_products/constants.dart';
import 'package:my_products/screens/admins/OrdersView.dart';

class AdminHome extends StatelessWidget {
  static String path = 'adminHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KmainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Addproduct.path);
              },
              child: Text('Add Product')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ManageProduct.path);
              },
              child: Text('Manage Product')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(OrdersView.path);
              },
              child: Text('View Orders'))
        ],
      ),
    );
  }
}
