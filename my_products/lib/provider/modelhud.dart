import 'package:flutter/material.dart';

class ModelHud extends ChangeNotifier {
  bool isLoading = false;

  ChangeisLoading(value) {
    isLoading = value;
    notifyListeners();
  }
}
