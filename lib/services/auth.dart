import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword() async {
    try {
      Future<UserCredential> result = _auth.signInWithEmailAndPassword(
          email: 'torneobasce@gmail.com', password: 'TyLawson36');
      return result;
    } catch (e) {
      return null;
    }
  }
}
