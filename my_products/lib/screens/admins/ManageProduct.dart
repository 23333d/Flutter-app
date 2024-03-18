import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_products/models/product.dart';
import 'package:my_products/screens/admins/EditProduct.dart';
import 'package:my_products/constants.dart';
import 'package:my_products/services/store.dart';
import 'package:my_products/widgets/custom_menu.dart';

class ManageProduct extends StatefulWidget {
  static String path = 'ManageProduct';

  @override
  State<ManageProduct> createState() => _EditProductState();
}

class _EditProductState extends State<ManageProduct> {
  ///////////store here
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
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
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .8, crossAxisCount: 2),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: GestureDetector(
                      onTapUp: (details) async {
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery.of(context).size.width - dx;
                        double dy2 = MediaQuery.of(context).size.width - dy;
                        await showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            items: [
                              MyPopupMenu(
                                OnClick: () {
                                  Navigator.of(context).pushNamed(
                                      EditProduct.path,
                                      arguments: Products[index]);
                                },
                                child: Text('Edit'),
                              ),
                              MyPopupMenu(
                                  OnClick: () {
                                    _store.deleteProduct(Products[index].pId);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Delete'))
                            ]);
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
                                      style: TextStyle(
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

              return Center(
                child: Text('Loading.....'),
              );
            }));
  }
}
