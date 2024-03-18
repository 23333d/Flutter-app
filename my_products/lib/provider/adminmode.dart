import 'package:flutter/foundation.dart';

class Adminmode extends ChangeNotifier {
  bool Isadmin = false;
  changeIsAdmin(bool value) {
    Isadmin = value;
    notifyListeners();
  }
}
