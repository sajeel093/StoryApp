import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
//signup
  static Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("Singup");
    } catch (e) {
      print("Signup Error: $e");
    }
  }

  //signIn
  static Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("SignIn Error: $e");
    }
  }
}
