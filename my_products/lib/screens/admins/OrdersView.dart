import 'package:flutter/material.dart';
import 'package:my_products/constants.dart';
import 'package:my_products/models/Order.dart';
import 'package:my_products/screens/admins/OrderDetails.dart';
import 'package:my_products/services/store.dart';

class OrdersView extends StatelessWidget {
  static String path = 'OrdersView';
  Store store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 238, 255),
      body: StreamBuilder(
          stream: store.loadOreders(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('there is no Orders'),
              );
            } else {
              List<Order> Orders = [];
              for (var order in snapshot.data!.docs) {
                var data = order.data() as Map<dynamic, dynamic>;
                Orders.add(Order(
                    DocumentId: order.id,
                    TotalPrice: data[kTotalPrice],
                    address: data[kAddress]));
              }
              return ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(OrderDetails.path,
                          arguments: Orders[index].DocumentId);
                    },
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
                              'Total Price = \$${Orders[index].TotalPrice.toString()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'address is ${Orders[index].address}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: Orders.length,
              );
            }
          }),
    );
  }
}
