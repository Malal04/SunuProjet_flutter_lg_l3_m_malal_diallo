import 'package:diallo_mamadou_malal_l3gl_examen/screens/auth/signup_screen.dart';
import 'package:diallo_mamadou_malal_l3gl_examen/screens/publics/accuiel_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../config/constants/constants_assets.dart';
import '../../config/constants/constants_color.dart';
import '../../services/auth/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool isObscured = true;
  bool isLoading = false;
  String? errorMessage;

  Future<void> _signIn() async {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        await authService.loginWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        setState(() => isLoading = false);
        Navigator.pushReplacementNamed(
            context,
            AccueilScreen.routeName
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Vous êtes connecté !",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold
              ),
            ),
            duration: Duration(seconds: 5),
            backgroundColor: kPrimaryColor,
          ),
        );
      } on FirebaseAuthException catch (ex) {
        setState(() {
          isLoading = false;
          switch (ex.code) {
            case 'user-not-found':
              errorMessage = 'Aucun utilisateur trouvé pour cet email';
              break;
            case 'wrong-password':
              errorMessage = 'Email ou mot de passe incorrect';
              break;
            default:
              errorMessage = ex.message;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage!,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold
              ),
            ),
            duration: Duration(seconds: 5),
            backgroundColor: kErrorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 120),
                Center(
                  child: SizedBox(
                    height: 140,
                    width: 140,
                    child: const Image(image: AssetImage(kAppLogo)),
                  ),
                ),
                const Text(
                  "Connectez-vous pour continuer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 35),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Entrez votre email',
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Veuillez entrer votre email';
                          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                            return 'Veuillez entrer un email valide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: isObscured,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          hintText: 'Entrez votre mot de passe',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off),
                            onPressed: () => setState(() => isObscured = !isObscured),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Veuillez entrer votre mot de passe';
                          if (value.length < 6) return 'Le mot de passe doit contenir au moins 6 caractères';
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                              "Mot de passe oublié ?",
                              style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _signIn,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kSecondaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              )),
                          child: isLoading
                              ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(kPrimaryColor))
                              : Text(
                              "Se connecter",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: kWhiteColor
                              )),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Vous n'avez pas de compte ? ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold
                              )),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, SignupScreen.routeName),
                            child: const Text("S'inscrire",
                                style: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
