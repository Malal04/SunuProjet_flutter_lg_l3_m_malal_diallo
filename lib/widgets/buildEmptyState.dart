import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildEmptyState() {
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