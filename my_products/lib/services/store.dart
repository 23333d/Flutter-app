import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_products/models/product.dart';
import 'package:my_products/constants.dart';

class Store {
  final FirebaseFirestore _Firestore = FirebaseFirestore.instance;

  Addproduct(product product) {
    _Firestore.collection(KproductCollection).add({
      KproductName: product.pName,
      KproductDescription: product.pDescription,
      KproductLocation: product.pLocaion,
      KproductCatogary: product.pCatogary,
      KproductPrice: product.pPrice
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    // var snapshot = await _Firestore.collection(KproductCollection).get();
    return _Firestore.collection(KproductCollection).snapshots();
  }

////to orders
  Stream<QuerySnapshot> loadOreders() {
    return _Firestore.collection(kOrders).snapshots();
  }

//to orderDetails
  Stream<QuerySnapshot> loadOrederDetails(documentId) {
    return _Firestore.collection(kOrders)
        .doc(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }

  deleteProduct(DocumentId) {
    _Firestore.collection(KproductCollection).doc(DocumentId).delete();
  }

  editProduct(data, DocumentId) {
    _Firestore.collection(KproductCollection).doc(DocumentId).update(data);
  }

  storeOrders(data, List<product> Products) {
    var DocumntRef = _Firestore.collection(kOrders).doc();
    DocumntRef.set(data);
    for (var product in Products) {
      DocumntRef.collection(kOrderDetails).doc().set({
        KproductName: product.pName,
        KproductLocation: product.pLocaion,
        KproductPrice: product.pPrice,
        KproductQuantity: product.pQuantity,
        KproductCatogary: product.pCatogary
      });
    }
  }
}
