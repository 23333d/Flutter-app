import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_products/constants.dart';
import 'package:my_products/provider/adminmode.dart';
import 'package:my_products/provider/cartItem.dart';
import 'package:my_products/provider/modelhud.dart';
import 'package:my_products/screens/User/CartScreen.dart';
import 'package:my_products/screens/User/ProductInfo.dart';
import 'package:my_products/screens/admins/AddProduct.dart';
import 'package:my_products/screens/admins/AdminHome.dart';
import 'package:my_products/screens/User/Home.dart';
import 'package:my_products/Register/SignUp.dart';
import 'package:my_products/screens/admins/EditProduct.dart';
import 'package:my_products/screens/admins/ManageProduct.dart';
import 'package:my_products/Register/login.dart';
import 'package:my_products/screens/admins/OrderDetails.dart';
import 'package:my_products/screens/admins/OrdersView.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            home: Scaffold(body: Center(child: Text('isLoading...'))),
          );
        } else {
          isUserLoggedIn = snapshot.data?.getBool(KkeepLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<cartItem>(
                create: (context) => cartItem(),
              ),
              ChangeNotifierProvider<ModelHud>(
                create: (context) => ModelHud(),
              ),
              ChangeNotifierProvider<Adminmode>(
                  create: (context) => Adminmode())
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggedIn ? HomePage.path : login.path,
              routes: {
                login.path: (context) => login(),
                SignUpScreen.Path: (context) => SignUpScreen(),
                HomePage.path: (context) => HomePage(),
                AdminHome.path: (context) => AdminHome(),
                Addproduct.path: (context) => Addproduct(),
                ManageProduct.path: (context) => ManageProduct(),
                EditProduct.path: (context) => EditProduct(),
                ProductInfo.path: (context) => ProductInfo(),
                CartScreen.path: (context) => CartScreen(),
                OrdersView.path: (context) => OrdersView(),
                OrderDetails.path: (context) => OrderDetails()
              },
            ),
          );
        }
      },
    );
  }
}
