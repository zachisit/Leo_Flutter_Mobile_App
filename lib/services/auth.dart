import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leo/user/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInAnon();
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Future<User> signInWithEmailPass(String email, String password);
  Future<User> createUserWithEmailPass(String email, String password);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) =>
      (user == null) ? null : User(uid: user.uid);

  // only hold data type User in this Stream
  //
  // the map operator transforms into a new
  //  stream event
  @override
  Stream<User> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();

    if (googleAccount != null) {
      GoogleSignInAuthentication googleAuth = await googleAccount
          .authentication;

      if (googleAuth.accessToken != null &&
          googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase((authResult.user));
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Sign in aborted by user',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<User> signInAnon() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithEmailPass(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailPass(String email, String password) async {
    print('create User With Email PAss');
    print(email);
    print(password);
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    print('here');
    print(authResult);
    print(authResult.user);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}