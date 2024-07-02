import 'dart:async';

import 'package:brew_crew/models/custom_user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on my custom user
  CustomUser? _customUserFromUser(User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  Stream<CustomUser?> get userAuthState {
    return _auth.authStateChanges().map(_customUserFromUser);
    // .map((User? user) => _customUserFromUser(user));
  }

  Future<CustomUser?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _customUserFromUser(user);
    } catch (e) {
      return null;
    }
  }

  Future<CustomUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _customUserFromUser(user);
    } catch (e) {
      return null;
    }
  }

  Future<CustomUser?> signUpWithEmailAndPassword(
      String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    if (user == null) {
      return null;
    }
    //create a new document for the new user with the uid
    await DatabaseService(uid: user.uid)
        .createUserData('new_crew_member', '0', 100);
    return _customUserFromUser(user);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
