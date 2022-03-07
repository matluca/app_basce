import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword() async {
    String pwd = await loadAsset();
    try {
      Future<UserCredential> result = _auth.signInWithEmailAndPassword(
          email: 'torneobasce@gmail.com', password: pwd);
      return result;
    } catch (e) {
      return null;
    }
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/pwd.txt');
}
