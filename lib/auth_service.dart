import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      print('Signed in');
      return("Signed in");
    }catch(e) {
      return e.message;
    }
  }


  Future<String> signUp({String username, String email, String password}) async {
    print('here');
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((result) {
      dbRef
          .child(result.user.uid)
          .set({"username": username, "email": email}).then((res) {
        return true;
      });
    }).catchError((error) {
      throw (error);
    });
    return "failed";
  }
}
