import 'package:diallo_mamadou_malal_l3gl_examen/screens/publics/creer/projet_creer_screen.dart';
import 'package:flutter/material.dart';
import '../../../config/constants/constants_color.dart';

class ProjetTabView extends StatelessWidget {
  final List<Map<String, String>> projets = [
    // Simule une liste de projets existants
    {
      "nom": "Test",
      "description": "Description du projet",
      "priorite": "Urgente",
      "statut": "En attente",
      "echeance": "12/08/2025"
    },
    {
      "nom": "Plateforme E-Commerce",
      "description": "Plateforme de commerce en ligne",
      "priorite": "Haute",
      "statut": "En attente",
      "echeance": "31/08/2025"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Champ de recherche
            TextField(
              decoration: InputDecoration(
                labelText: 'Rechercher un projet...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey.shade800),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Vérifier s'il y a des projets à afficher
            Expanded(
              child: projets.isEmpty
                  ? _buildEmptyState() // Afficher le message "Aucun projet trouvé"
                  : _buildProjectList(), // Afficher la liste des projets
            ),
          ],
        ),
      ),

      // Bouton pour ajouter un projet
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreerProjet(),
            ),
          );
        },
        backgroundColor: kSecondaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Widget pour afficher "Aucun projet trouvé"
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder, size: 100, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            "Aucun projet trouvé",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          const SizedBox(height: 5),
          const Text(
            "Créez un nouveau projet pour commencer.",
            style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Widget pour afficher la liste des projets
  Widget _buildProjectList() {
    return ListView.builder(
      itemCount: projets.length,
      itemBuilder: (context, index) {
        final projet = projets[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(projet["nom"] ?? "Sans nom", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(projet["description"] ?? "Pas de description"),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(projet["priorite"] ?? "", style: TextStyle(color: Colors.red)),
                Text("📅 ${projet["echeance"]}", style: TextStyle(fontSize: 12)),
              ],
            ),
            onTap: () {
              // Action quand on clique sur un projet (redirection vers détail)
            },
          ),
        );
      },
    );
  }
}
