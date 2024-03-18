import 'package:flutter/material.dart';
import 'package:my_products/constants.dart';
import 'package:my_products/models/product.dart';
import 'package:my_products/services/store.dart';

class OrderDetails extends StatelessWidget {
  static String path = 'OrderDetails';
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context)?.settings.arguments as String;
    Store store = Store();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 238, 255),
      body: StreamBuilder(
          stream: store.loadOrederDetails(documentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<product> Products = [];
              for (var doc in snapshot.data!.docs) {
                var data = doc.data() as Map<dynamic, dynamic>;
                Products.add(product(
                  pCatogary: data[KproductCatogary].toString(),
                  pQuantity: data[KproductQuantity],
                  pName: data[KproductName].toString(), pDescription: '',
                  pPrice: '', pLocaion: '',
                  // pLocaion: data[KproductLocation].toString(),
                  // pDescription: data[KproductDescription].toString(),
                  // pPrice: data[KproductPrice].toString(),
                ));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: Products.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: KsecondColor),
                          height: MediaQuery.of(context).size.height * .14,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Product Name : ${Products[index].pName}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Quantity is : ${Products[index].pQuantity}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Product Catogary is : ${Products[index].pCatogary}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {}, child: Text('Confirm Order')),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {}, child: Text('Delete Order')),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('Loading Order Details'),
              );
            }
          }),
    );
  }
}
