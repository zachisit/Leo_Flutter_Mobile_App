import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_leo/services/auth.dart';
import 'package:flutter_leo/user/user.dart';

class SignInManager {
  SignInManager({@required this.auth, @required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInAnon() async => await _signIn(auth.signInAnon);

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
}