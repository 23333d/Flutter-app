import 'package:flutter/material.dart';
import 'package:my_products/models/product.dart';
import 'package:my_products/constants.dart';
import 'package:my_products/services/store.dart';
import 'package:my_products/widgets/CutomTextField.dart';

class EditProduct extends StatelessWidget {
  static String path = 'EditProduct';
  late String _name, _description, _imagesLocation, _price, _catogary;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    product? pproduct = ModalRoute.of(context)!.settings.arguments as product?;
    return Scaffold(
        backgroundColor: KmainColor,
        body: Form(
          key: _globalKey,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cutomTextField(
                      'Product Name', Icons.production_quantity_limits_rounded,
                      onClick: (value) {
                    _name = value;
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  cutomTextField('Product Price', Icons.price_change,
                      onClick: (value) {
                    _price = value;
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  cutomTextField('Product Description', Icons.description,
                      onClick: (value) {
                    _description = value;
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  cutomTextField('Product Catogary', Icons.category,
                      onClick: (value) {
                    _catogary = value;
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  cutomTextField('Product Location', Icons.location_on_rounded,
                      onClick: (value) {
                    _imagesLocation = value;
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          _globalKey.currentState?.save();
                          _store.editProduct(
                              ({
                                KproductName: _name,
                                KproductCatogary: _catogary,
                                KproductDescription: _description,
                                KproductLocation: _imagesLocation,
                                KproductPrice: _price
                              }),
                              pproduct?.pId);
                        }
                      },
                      child: Text('Edit product'))
                ],
              )
            ],
          ),
        ));
  }
}
