import 'package:mobi_chat/models/auth_user.dart';
import 'package:mobi_chat/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthUser? _initialiseUser(User? user) {
    return user != null ? AuthUser(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<User?> get authUser {
    return _auth.userChanges();
  }

  // Register with email and password
  Future<List<dynamic>> register(
      {required name, required email, required password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await DatabaseService(uid: userCredential.user!.uid)
          .registerUser(name, email);
      return [_initialiseUser(userCredential.user), ''];
    } on FirebaseAuthException catch (e) {
      return [null, e.message];
    }
  }

  // Sign in with email and password
  Future<List<dynamic>> signin({required email, required password}) async {
    try {
      UserCredential? userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return [_initialiseUser(userCredential.user), ''];
    } on FirebaseAuthException catch (e) {
      return [null, e.message];
    }
  }

  // Sign out
  Future signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      e.toString();
      return null;
    }
  }
}
