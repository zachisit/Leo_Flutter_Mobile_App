import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_leo/user/user.dart';

abstract class AuthBase{
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInAnon();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) => (user == null) ? null : User(uid: user.uid);

  // only hold data type User in this Stream
  //
  // the map operator transforms into a new
  //  stream event
  @override
  Stream<User> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInAnon() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();
}