import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class Auth with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;

  Auth.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;


  /**
   * @function{{signIn}}
   * @description{{Email/Password based signin for user}}
   * @param email: String
   * @param password: String
   */
  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {      
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }


  /**
   * @function{{signUp}}
   * @description{{Email/Password based signUp for user}}
   * @param email: String
   * @param password: String
   */
  Future<bool> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await storeUserDetails(email);
      await sendVerificationMail();

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }


  /**
   * @function{{storeUserDetails}}
   * @description{{Save user's data in Firestore collection}}
   * @param email: String
   */
  Future storeUserDetails(String email) async {
    var data = {
      "email": email,
      "createdAt": new DateTime.now().millisecondsSinceEpoch,
      "userid": user.uid
    };
    await Firestore.instance
        .collection('users')
        .document(user.uid)
        .setData(data);
  }


  /**
   * @function{{sendVerificationMail}}
   * @description{{Send verification email to user post signup}}
   */
  Future sendVerificationMail() async {
    await user.sendEmailVerification();
  }


  /**
   * @function{{changePassword}}
   * @description{{Change Password for user}}
   * @param oldPassword: String
   * @param newPassword: String
   */  
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {

      final AuthCredential credential = EmailAuthProvider.getCredential(
          email: user.email, password: oldPassword);

      final AuthResult result =
          await user.reauthenticateWithCredential(credential);
      print('inside AuthResult');
      print(result.user);

      await updatePassword(newPassword);

      return true;
    } on PlatformException catch (e) {
      return false;
    } catch (e) {
      await updatePassword(newPassword);

      return true;
    }
  }


  /**
   * @function{{updatePassword}}
   * @description{{Update Password for user}}
   * @param newPassword: String
   */
  Future<bool> updatePassword(newPassword) async {
    try {
      await user.updatePassword(newPassword);
      return true;
    } catch (e) {
      print('update Password error : ');
      print(e);
      return false;
    }
  }

  
  /**
   * @function{{signOut}}
   * @description{{Signout user and clear the session}}
   * @param newPassword: String
   */
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }


  /**
   * @function{{_onAuthStateChanged}}
   * @description{{Auth state change listener. Fires whenever the auth state changed upon login/signup/signout}}
   * @param firebaseUser: FirebaseUser
   */
  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      user.reload();
    }
    notifyListeners();
  }


  /**
   * @function{{forgetPassword}}
   * @description{{Send Password recovery email when user forget there password}}
   * @param email: String
   */
  Future forgetPassword(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

}
