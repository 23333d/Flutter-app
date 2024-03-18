import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_products/provider/adminmode.dart';
import 'package:my_products/provider/modelhud.dart';
import 'package:my_products/screens/admins/AdminHome.dart';
import 'package:my_products/screens/User/Home.dart';
import 'package:my_products/Register/SignUp.dart';
import 'package:my_products/constants.dart';
import 'package:my_products/services/auth.dart';
import 'package:my_products/widgets/Custom_logo.dart';
import 'package:my_products/widgets/CutomTextField.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  static String path = 'login page';

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final AdminPassord = 'admin12345';

  late String _email, _password;

  bool keepMeLoggedIn = false;

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
              cutomTextField('Enter Your Email', Icons.email, onClick: (value) {
                _email = value;
              }),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                          activeColor: Colors.blueAccent,
                          value: keepMeLoggedIn,
                          onChanged: (value) {
                            setState(() {
                              keepMeLoggedIn = value!;
                            });
                          }),
                    ),
                    Text(
                      'Remmber Me',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              cutomTextField(onClick: (value) {
                _password = value;
              }, 'Enter Your Password', Icons.password),
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
                        if (keepMeLoggedIn == true) {
                          keepUserLoggedIn();
                        }
                        _vaildate(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUpScreen.Path);
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<Adminmode>(context, listen: false)
                              .changeIsAdmin(true);
                        },
                        child: Text(
                          'i\'am a Admin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<Adminmode>(context).Isadmin
                                ? KmainColor
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<Adminmode>(context, listen: false)
                              .changeIsAdmin(false);
                        },
                        child: Text(
                          'i\'am a User',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<Adminmode>(context).Isadmin
                                ? Colors.white
                                : KmainColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _vaildate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.ChangeisLoading(true);
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();
      if (Provider.of<Adminmode>(context, listen: false).Isadmin) {
        if (_password == AdminPassord) {
          try {
            await auth.signin(_email, _password);
            Navigator.of(context).pushNamed(AdminHome.path);
          } on FirebaseAuthException catch (e) {
            modelhud.ChangeisLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.message ?? '')),
            );
          }
        } else {
          modelhud.ChangeisLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('something went wrong')),
          );
        }
      } else {
        try {
          await auth.signin(_email, _password);
          Navigator.of(context).pushNamed(HomePage.path);
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? '')),
          );
        }
      }
    }
    modelhud.ChangeisLoading(false);
  }

  void keepUserLoggedIn() async {
    SharedPreferences preference =
        await SharedPreferences.getInstance() as SharedPreferences;
    preference.setBool(KkeepLoggedIn, keepMeLoggedIn);
  }
}
