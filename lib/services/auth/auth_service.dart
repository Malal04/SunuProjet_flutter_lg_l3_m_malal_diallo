import 'package:diallo_mamadou_malal_l3gl_examen/services/auth/db_user.dart';
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
    required String nom
  }) async {
    final resul = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    final user = resul.user;
    if(user != null){
      await DbUserService().saveUser(UserModel(id: user.uid, email: email, nom: nom));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<void> resetPassword({required String email}) async {
    try {
      // Vérifier si l'email existe
      final signInMethods = await _auth.fetchSignInMethodsForEmail(email);

      if (signInMethods.isEmpty) {
        throw FirebaseAuthException(message: "Aucun compte trouvé pour cet email", code: '');
      }

      await _auth.sendPasswordResetEmail(email: email);
      print("Email de réinitialisation envoyé");
    } on FirebaseAuthException catch (e) {
      print("Erreur lors de l'envoi de l'email de réinitialisation: ${e.message}");
    }
  }

}
