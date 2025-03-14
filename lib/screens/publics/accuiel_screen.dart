import 'package:diallo_mamadou_malal_l3gl_examen/screens/publics/tab/projet_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/constants/constants_assets.dart';
import '../../config/constants/constants_color.dart';
import '../../services/auth/auth_service.dart';


class AccueilScreen extends StatefulWidget {
  static const String routeName = '/accueil';
  const AccueilScreen({super.key});

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  Future<void> signOut(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.signOut();

    if (!mounted) return; // Vérifie si le widget est encore monté
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user; // Récupérer l'utilisateur connecté

    return DefaultTabController(
      length: 4, // 4 onglets
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          foregroundColor: Colors.white,
          title: const Text(
            "SunJob",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(kAppProfil),
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "En attente"),
              Tab(text: "En cours"),
              Tab(text: "Terminés"),
              Tab(text: "Annulés"),
            ],
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white, // Drawer en blanc
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(kAppProfil),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Bienvenue, ${user?.email ?? 'Invité'}",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.black54),
                title: const Text('Paramètres', style: TextStyle(color: Colors.black87)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.account_box, color: Colors.black54),
                title: const Text('Profil', style: TextStyle(color: Colors.black87)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.black54),
                title: const Text('Aide', style: TextStyle(color: Colors.black87)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Déconnexion', style: TextStyle(color: Colors.black87)),
                onTap: () => signOut(context),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProjetTabView(),
            ProjetTabView(),
            ProjetTabView(),
            ProjetTabView(),
          ],
        ),
      ),
    );
  }
}
