import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Yes";
    } catch (e) {
      if (e.code == "wrong-password") return "Wrong password";
      return "Wrong email address";
    }
  }
  Future signOut() async{
    await _auth.signOut();
  }
}
