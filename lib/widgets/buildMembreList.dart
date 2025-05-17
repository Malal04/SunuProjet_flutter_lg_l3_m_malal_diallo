import 'package:flutter/material.dart';
import '../models/projet_model.dart';
import '../screens/publics/creer/AddMemberPage.dart';


Widget buildMembreList(ProjectModel project, BuildContext context) {
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Membres du projet :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: project.memberIds.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(project.memberIds[index]),
              );
            },
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddMemberPage(projectId: project.id),
          ),
        );
      },
      child: Icon(Icons.add),
      tooltip: "Ajouter un membre",
    ),
  );
}
