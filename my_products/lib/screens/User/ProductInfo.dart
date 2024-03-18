import 'package:flutter/material.dart';
import 'package:my_products/constants.dart';
import 'package:my_products/models/product.dart';
import 'package:my_products/provider/cartItem.dart';
import 'package:my_products/screens/User/CartScreen.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String path = 'ProductInfo';

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _Quantitynum = 1;
  @override
  Widget build(BuildContext context) {
    product pproduct = ModalRoute.of(context)?.settings.arguments as product;
    return Scaffold(
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Container(
            height: MediaQuery.of(context).size.height * .1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(CartScreen.path);
                      },
                      child: Icon(Icons.shopping_cart))
                ]),
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(image: AssetImage(pproduct.pLocaion))),
        Positioned(
          bottom: 0,
          child: Column(
            children: [
              Opacity(
                opacity: .5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pproduct.pName,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          pproduct.pDescription,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '\$${pproduct.pPrice}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Material(
                                color: KmainColor,
                                child: GestureDetector(
                                  onTap: add,
                                  child: SizedBox(
                                    child: Icon(Icons.add),
                                    height: 32,
                                    width: 32,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              _Quantitynum.toString(),
                              style: TextStyle(fontSize: 50),
                            ),
                            ClipOval(
                              child: Material(
                                color: KmainColor,
                                child: GestureDetector(
                                  onTap: subtract,
                                  child: SizedBox(
                                    child: Icon(Icons.remove),
                                    height: 32,
                                    width: 32,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ButtonTheme(
                height: MediaQuery.of(context).size.height * .09,
                minWidth: MediaQuery.of(context).size.width,
                child: Builder(builder: (context) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)))),
                      onPressed: () {
                        addToCart(context, pproduct);
                      },
                      child: Text(
                        'add to cart'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ));
                }),
              ),
            ],
          ),
        )
      ]),
    );
  }

  add() {
    setState(() {
      _Quantitynum++;
    });
  }

  void subtract() {
    if (_Quantitynum > 0) {
      setState(() {
        _Quantitynum--;
      });
    }
  }

  void addToCart(Context, pproduct) {
    cartItem cart = Provider.of<cartItem>(context, listen: false);
    pproduct.pQuantity = _Quantitynum;
    bool exist = false;
    var productInCart = cart.Products;
    for (var productInCart in productInCart) {
      if (productInCart.pName == pproduct.pName) {
        exist = true;
      }
    }
    if (exist) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('you\'ve added this item before')));
    } else {
      cart.Addproduct(pproduct);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Added to cart')));
    }
  }
}
