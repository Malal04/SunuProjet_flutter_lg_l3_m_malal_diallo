import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../config/constants/constants_assets.dart';
import '../../config/constants/constants_color.dart';

class ResteScreen extends StatefulWidget {
  static const String routeName = '/resete';
  const ResteScreen({super.key});

  @override
  State<ResteScreen> createState() => _ResteScreenState();
}

class _ResteScreenState extends State<ResteScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // Fonction pour envoyer l'email de réinitialisation
  Future<void> _resetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });
      try {
        // Vérification si l'email est associé à un utilisateur
        final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(_emailController.text.trim());

        if (signInMethods.isEmpty) {
          // Si aucune méthode de connexion n'est associée à cet email
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Aucun compte trouvé pour cet email")),
          );
          setState(() {
            isLoading = false;
          });
        } else {
          // Envoi de l'email de réinitialisation
          await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Un email de réinitialisation a été envoyé")),
          );
          // Optionnel: Retour à l'écran de connexion après réinitialisation réussie
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur: ${e.message}")),
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
                  "Récupération de mot de passe",
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
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _resetPassword,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kSecondaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              )),
                          child: isLoading
                              ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(kPrimaryColor))
                              : Text(
                              "Envoyer un email de réinitialisation",
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
                          const Expanded(
                            child: Text(
                              "Vous vous souvenez de votre mot de passe ? ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis, // Troncature si le texte est trop long
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context), // Retour à l'écran de connexion
                            child: const Text(
                              "Se connecter",
                              style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800
                              ),
                            ),
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
