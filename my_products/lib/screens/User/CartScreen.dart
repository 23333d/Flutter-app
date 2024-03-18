import 'package:flutter/material.dart';
import 'package:my_products/constants.dart';
import 'package:my_products/models/product.dart';
import 'package:my_products/provider/cartItem.dart';
import 'package:my_products/screens/User/ProductInfo.dart';
import 'package:my_products/services/store.dart';
import 'package:my_products/widgets/custom_menu.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String path = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    List<product> Products = Provider.of<cartItem>(context).Products;
    final double screenHight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appbarhight = AppBar().preferredSize.height;
    final double statusAppbar = MediaQuery.of(context).padding.top;
    return Scaffold(
      ///for error
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          LayoutBuilder(builder: (context, constrains) {
            if (Products.isNotEmpty) {
              return Container(
                height: screenHight -
                    statusAppbar -
                    appbarhight -
                    (screenHight * .08),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTapUp: (details) {
                          showCustomMenu(details, context, Products[index]);
                        },
                        child: Container(
                          height: screenHight * .11,
                          color: KsecondColor,
                          child: Row(children: [
                            CircleAvatar(
                              radius: screenHight * .11 / 2,
                              backgroundImage:
                                  AssetImage(Products[index].pLocaion),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(Products[index].pName,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '\$${Products[index].pPrice}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      Products[index].pQuantity.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    );
                  },
                  itemCount: Products.length,
                ),
              );
            } else {
              return Container(
                  height: screenHight -
                      (screenHight * .08) -
                      appbarhight -
                      statusAppbar,
                  child: Center(child: Text('Cart is Empty')));
            }
          }),
          ButtonTheme(
              minWidth: screenWidth,
              height: screenHight * .09,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)))),
                  onPressed: () {
                    showCustomDialog(Products, context);
                  },
                  child: Text(
                    'order'.toUpperCase(),
                  )))
        ],
      ),
    );
  }

  void showCustomMenu(details, context, prod) async {
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
              Navigator.pop(context);
              Provider.of<cartItem>(context, listen: false).deleteProduct(prod);
              Navigator.of(context)
                  .pushNamed(ProductInfo.path, arguments: prod);
            },
            child: Text('Edit'),
          ),
          MyPopupMenu(
              OnClick: () {
                Navigator.pop(context);
                Provider.of<cartItem>(context, listen: false)
                    .deleteProduct(prod);
              },
              child: Text('Delete'))
        ]);
  }

  void showCustomDialog(List<product> Products, context) async {
    var price = getTotalPrice(Products);
    var address;
    AlertDialog alert = AlertDialog(
      actions: [
        MaterialButton(
          onPressed: () {
            Store store = Store();
            try {
              store.storeOrders({
                kTotalPrice: price,
                kAddress: address,
              }, Products);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('orderd successfully')));
            } catch (ex) {
              print(ex);
            }
          },
          child: Text('confirm'),
        )
      ],
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(hintText: 'Enter Address'),
      ),
      title: Text('Total price =\$ $price'),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  getTotalPrice(List<product> products) {
    num price = 0;
    for (var prod in products) {
      price += (prod.pQuantity! * int.parse(prod.pPrice));
    }
    return price;
  }
}
