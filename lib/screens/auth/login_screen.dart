import 'package:diallo_mamadou_malal_l3gl_examen/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import '../../config/constants/constants_assets.dart';
import '../../config/constants/constants_color.dart';


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
  bool isObscured = true;
  bool isLoading = false;
  _signIn() async {}

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
           child: SingleChildScrollView(
             child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 20),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const SizedBox(height: 120,),
                   Center(
                     child: SizedBox(
                       height: 140,
                       width: 140,
                       child: const Image(
                         image: AssetImage(kAppLogo),
                         height: 50,
                       ),
                     ),
                   ),
                   const Text(
                     " Connectez-vous pour continuer ",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       fontSize: 18,
                       color: Colors.grey,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   const SizedBox(height: 35,),
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
                                   borderRadius: BorderRadius.circular(10),
                                 ),
                                 enabledBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(5),
                                   borderSide: BorderSide(color: Colors.grey.shade400),
                                 ),
                                 focusedBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(10),
                                   borderSide: BorderSide(
                                     color: Theme.of(context).primaryColor,
                                     width: 2,
                                   ),
                                 ),
                                 floatingLabelBehavior: FloatingLabelBehavior.always,
                             ),
                             validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return 'Veuillez entrer votre email';
                               }
                               if (!value.contains('@')) {
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
                               labelText: ' Mot de passe ',
                               hintText: ' Entrez votre mot de passe ',
                               prefixIcon: const Icon(Icons.lock_outline),
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                               ),
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(5),
                                 borderSide: BorderSide(color: Colors.grey.shade400),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: BorderSide(
                                   color: Theme.of(context).primaryColor,
                                   width: 2,
                                 ),
                               ),
                               floatingLabelBehavior: FloatingLabelBehavior.always,
                               suffixIcon: IconButton(
                                   icon: isObscured
                                       ? Icon(Icons.visibility)
                                       : Icon(Icons.visibility_off),
                                   color: Colors.black,
                                   onPressed: () {
                                     setState(() {
                                       isObscured =!isObscured;
                                     });
                                   })
                             ),
                             validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return 'Veuillez entrer votre mot de passe';
                               }
                               if (value.length < 6) {
                                 return 'Le mot de passe doit contenir au moins 6 caractères';
                               }
                               return null;
                             },
                           ),
                           const SizedBox(height: 10),
                           Align(
                               alignment: Alignment.centerRight,
                               child: TextButton(
                                 onPressed: () {
                                 },
                                 child: const Text(
                                   "Mot de passe oublié ?",
                                   style: TextStyle(
                                     color: kSecondaryColor,
                                     fontSize: 16,
                                     fontWeight: FontWeight.w800,
                                   ),
                                 ),
                               ),
                           ),
                           const SizedBox(height: 10,),
                           SizedBox(
                             width: double.infinity,
                             height: 55,
                             child: ElevatedButton(
                               onPressed: isLoading ? null : _signIn,
                               style: ElevatedButton.styleFrom(
                                   backgroundColor: kSecondaryColor,
                                   shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(5)
                                   )
                               ),
                               child: isLoading
                                   ? SizedBox(
                                 child: CircularProgressIndicator(
                                   strokeWidth: 5,
                                   valueColor: AlwaysStoppedAnimation(
                                       kPrimaryColor
                                   ),
                                 ),
                               ) : Text(
                                 "Se ceonnecter",
                                 style: TextStyle(
                                     fontWeight: FontWeight.w600,
                                     fontSize: 16,
                                     color: kWhiteColor
                                 ),

                               ),
                             ),
                           ),
                           const SizedBox(height: 15),
                           Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 const Text(
                                   "Vous n'avez pas de compte ? ",
                                   style: TextStyle(
                                       fontSize: 16,
                                       color: Colors.grey,
                                       fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 TextButton(
                                   onPressed: () {
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                         builder: (context) => SignupScreen(),
                                       ),
                                     );
                                   },
                                   child: const Text(
                                     " S'inscrire ",
                                     style: TextStyle(
                                       color: kSecondaryColor,
                                       fontSize: 16,
                                       fontWeight: FontWeight.w800,
                                     ),
                                   ),
                                 ),
                               ],
                           ),
                         ]
                       ),
                   ),
                 ],
               ),
             ),
           )
       ),
     );
  }

}
