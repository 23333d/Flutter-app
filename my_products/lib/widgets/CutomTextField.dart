import 'package:flutter/material.dart';
import 'package:my_products/constants.dart';

Padding cutomTextField(String Hint, IconData icon,
    {Null Function(dynamic value)? onClick}) {
  _errorMessage(String Hint) {
    switch (Hint) {
      case 'Enter Your Name':
        return 'Name is empty!';
      case 'Enter Your Email':
        return 'Email is empty!';
      case 'Enter Your Password':
        return 'Password is empty!';
    }
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return _errorMessage(Hint);
        }
      },
      onSaved: onClick,
      obscureText: Hint == 'Enter Your Password' ? true : false,
      cursorColor: KmainColor,
      decoration: InputDecoration(
          hintText: Hint,
          prefixIcon: Icon(
            icon,
            color: KmainColor,
          ),
          filled: true,
          fillColor: KsecondColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(

              ///for error situation
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white))),
    ),
  );
}
