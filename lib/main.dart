import 'package:diallo_mamadou_malal_l3gl_examen/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'config/routes/routes.dart';
import 'config/themes/theme.dart';
import 'firebase_options.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/publics/accuiel_screen.dart';
import 'screens/publics/creer/projet_creer_screen.dart';
import 'config/routes/redirection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        StreamProvider<User?>(
          create: (context) => AuthService().authStateChanges,
          initialData: null,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.system,
      home: const Redirection(),
      routes: {
        NavigationRoutes.accueil: (context) => AccueilScreen(),
        NavigationRoutes.signup: (context) => SignUpScreen(),
        NavigationRoutes.login: (context) => LoginScreen(),
        NavigationRoutes.creerProjet: (context) => CreerProjet(),
      },
    );
  }
}
