import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_products/provider/modelhud.dart';
import 'package:my_products/screens/User/Home.dart';
import 'package:my_products/constants.dart';
import 'package:my_products/Register/login.dart';
import 'package:my_products/services/auth.dart';
import 'package:my_products/widgets/Custom_logo.dart';
import 'package:my_products/widgets/CutomTextField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String Path = 'SignUpScreen';
  late String _email, _password;
  final auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KmainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              Custom_Img(context, 'Buy it', 'lib/images/icons/buy.png'),
              SizedBox(
                height: height * .1,
              ),
              cutomTextField(
                  onClick: (value) {}, 'Enter Your Name', Icons.perm_identity),
              SizedBox(
                height: height * .02,
              ),
              cutomTextField(onClick: (value) {
                _email = value;
              }, 'Enter Your Email', Icons.email),
              SizedBox(
                height: height * .02,
              ),
              cutomTextField('Enter Your Password', Icons.password,
                  onClick: (value) {
                _password = value;
              }),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.black),
                      onPressed: () async {
                        final modelhud =
                            Provider.of<ModelHud>(context, listen: false);
                        modelhud.ChangeisLoading(true);
                        if (_globalKey.currentState!.validate()) {
                          _globalKey.currentState?.save();
                          try {
                            final Authresult =
                                ////trim to ignore spaces
                                await auth.signup(
                                    _email.trim(), _password.trim());
                            modelhud.ChangeisLoading(false);
                            Navigator.of(context).pushNamed(HomePage.path);
                          } on FirebaseAuthException catch (e) {
                            modelhud.ChangeisLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.message ?? ''),
                                backgroundColor:
                                    Color.fromARGB(255, 23, 22, 21),
                              ),
                            );
                          }
                        }
                        modelhud.ChangeisLoading(false);
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do have an account ?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(login.path),
                    child: Text(
                      'login',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
