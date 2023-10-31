import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRemotDS {
  Future<void> signUp(String email, String password);
  Future<void> signIN(String email, String password);
  Future<void> signOut();
  bool isSignedIn();
}

class AuthenticationRemotDSImpl implements AuthenticationRemotDS {
  @override
  bool isSignedIn() {
   return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<void> signIN(String email, String password) async {
  
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signUp(String email, String password) async {
    
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
