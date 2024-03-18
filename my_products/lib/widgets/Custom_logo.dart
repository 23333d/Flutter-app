import 'package:flutter/material.dart';

Padding Custom_Img(BuildContext context, String text, String img) {
  return Padding(
    padding: const EdgeInsets.only(top: 50),
    child: Container(
      height: MediaQuery.of(context).size.height * .2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(img),
          Positioned(
            bottom: 0,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Pacifico',
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
