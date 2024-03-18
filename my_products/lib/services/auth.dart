import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signup(String Email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: Email, password: password);
    return (authResult);
  }

  Future<UserCredential> signin(String Email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: Email, password: password);
    return (authResult);
  }

  Future<void> SignOut() async {
    await _auth.signOut();
  }
}
