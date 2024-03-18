import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_products/Register/login.dart';
import 'package:my_products/models/product.dart';
import 'package:my_products/constants.dart';
import 'package:my_products/screens/User/CartScreen.dart';
import 'package:my_products/screens/User/ProductInfo.dart';
import 'package:my_products/services/auth.dart';
import 'package:my_products/services/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String path = 'Home Page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int _tabBarValue = 0;
  final _store = Store();
  final _auth = Auth();
  int _bottombar = 0;
  List<product> _Products = [];

  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
            length: 4,
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  fixedColor: KmainColor,
                  currentIndex: _bottombar,
                  unselectedItemColor: Color.fromARGB(255, 80, 78, 74),
                  // selectedItemColor: Colors.black,
                  //// selectedItemColor==fixedColor////////////
                  onTap: (value) async {
                    if (value == 1) {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance()
                              as SharedPreferences;
                      pref.clear();
                      await _auth.SignOut();
                      Navigator.of(context).popAndPushNamed(login.path);
                    }
                    setState(() {
                      _bottombar = value;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: 'comments',
                      icon: Icon(Icons.comment),
                    ),
                    BottomNavigationBarItem(
                      label: 'Sign out',
                      icon: Icon(Icons.close),
                    ),
                  ]),
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                bottom: TabBar(
                    indicatorColor: KmainColor,
                    onTap: (value) {
                      setState(() {
                        _tabBarValue = value;
                      });
                    },
                    tabs: [
                      Text(
                        'Jackets',
                        style: TextStyle(
                            color: _tabBarValue == 0
                                ? Colors.black
                                : KUnActiveColor,
                            fontSize: _tabBarValue == 0 ? 18 : null),
                      ),
                      Text(
                        'T-shirts',
                        style: TextStyle(
                            color: _tabBarValue == 1
                                ? Colors.black
                                : KUnActiveColor,
                            fontSize: _tabBarValue == 1 ? 18 : null),
                      ),
                      Text(
                        'Pants',
                        style: TextStyle(
                            color: _tabBarValue == 2
                                ? Colors.black
                                : KUnActiveColor,
                            fontSize: _tabBarValue == 2 ? 18 : null),
                      ),
                      Text(
                        'Coats',
                        style: TextStyle(
                            color: _tabBarValue == 3
                                ? Colors.black
                                : KUnActiveColor,
                            fontSize: _tabBarValue == 3 ? 18 : null),
                      ),
                    ]),
              ),
              body: TabBarView(children: [
                ProductView(Kjackets),
                ProductView(KTshirts),
                ProductView(KPants),
                ProductView(KCoats),
              ]),
            )),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover'.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(CartScreen.path);
                        },
                        child: Icon(Icons.shopping_cart))
                  ]),
            ),
          ),
        )
      ],
    );
  }

  Widget ProductView(String pCatopgary) {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          List<product> Products = [];
          if (snapshot.hasData) {
            for (var doc in snapshot.data!.docs) {
              var data = doc.data() as Map<dynamic, dynamic>;
              Products.add(product(
                pId: doc.id,
                pDescription: data[KproductDescription].toString(),
                pCatogary: data[KproductCatogary].toString(),
                pLocaion: data[KproductLocation].toString(),
                pName: data[KproductName].toString(),
                pPrice: data[KproductPrice].toString(),
              ));
            }
            _Products = [...Products];
            Products.clear();
            // Products = getProductByCatogary(pCatopgary, _Products);
            for (var product in _Products) {
              if (product.pCatogary == pCatopgary) {
                Products.add(product);
              }
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .8, crossAxisCount: 2),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.path,
                        arguments: Products[index]);
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(Products[index].pLocaion),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: 0.6,
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Products[index].pName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('\$${Products[index].pPrice}')
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: Products.length,
            );
          }
          return const Center(
            child: Text('Loading.....'),
          );
        });
  }
}
