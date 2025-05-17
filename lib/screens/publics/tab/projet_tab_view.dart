import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/ProjectProvider.dart';
import '../../../models/enums/status.dart';
import '../../../models/projet_model.dart';
import '../../../widgets/buildEmptyState.dart';
import '../../../widgets/buildProjectList.dart';
import '../../../config/constants/constants_color.dart';
import '../../../screens/publics/creer/projet_creer_screen.dart';

class ProjetTabView extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final ProjectStatus status;

  ProjetTabView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                projectProvider.searchProjects(query);
              },
              decoration: InputDecoration(
                labelText: 'Rechercher un projet...',
                labelStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    projectProvider.searchProjects('');
                  },
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<ProjectModel>>(
                stream: projectProvider.getProjectsStream(userId, status),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Erreur: ${snapshot.error}'));
                  }

                  final projets = snapshot.data ?? [];
                  if (projets.isEmpty) {
                    return buildEmptyState();
                  }
                  return buildProjectList(projets);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreerProjet()),
          );
        },
        backgroundColor: kSecondaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
