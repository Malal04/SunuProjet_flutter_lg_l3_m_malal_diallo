import 'package:diallo_mamadou_malal_l3gl_examen/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/routes/routes.dart';
import 'config/themes/theme.dart';


void main() {

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark
      )
  );

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: LoginScreen(),
      routes: {
        NavigationRoutes.login: (BuildContext context) => LoginScreen(),
      },

    );

  }

}
