
import 'package:diallo_mamadou_malal_l3gl_examen/screens/auth/login_screen.dart';
import 'package:diallo_mamadou_malal_l3gl_examen/screens/publics/accuiel_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth/auth_service.dart';

class Redirection extends StatefulWidget {
  const Redirection({super.key});

  @override
  State<Redirection> createState() => _RedirectionState();
}

class _RedirectionState extends State<Redirection> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        // Vérification de l'état de la connexion
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Vérification des erreurs
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Une erreur est survenue : ${snapshot.error}'),
            ),
          );
        }

        // Si l'utilisateur est connecté, on va à AccueilScreen
        if (snapshot.hasData) {
          return const AccueilScreen();
        } else {
          // Si l'utilisateur n'est pas connecté, on va à LoginScreen
          return const LoginScreen();
        }
      },
    );
  }
}
