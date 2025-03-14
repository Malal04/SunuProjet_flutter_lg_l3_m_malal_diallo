import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../models/user_model.dart';

class AuthService with ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  UserModel? _UserModel;
  User? get user => _user;
  UserModel? get myUserModel => _UserModel;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> setUser(UserModel user) async {
    _UserModel = user;
    notifyListeners();
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

}


