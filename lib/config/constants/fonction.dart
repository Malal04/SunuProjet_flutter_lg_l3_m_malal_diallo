import 'dart:ui';
import 'package:flutter/material.dart';

/// **Détermine la couleur en fonction de la priorité**
Color getPriorityColor(String priority) {
  switch (priority) {
    case 'Basse':
      return Colors.blue;
    case 'Moyenne':
      return Colors.green;
    case 'Haute':
      return Colors.orange;
    default:
      return Colors.red;
  }
}

/// **Détermine l'icône en fonction du statut**
IconData getStatusIcon(String status) {
  switch (status) {
    case 'EnAttente':
      return Icons.hourglass_empty;
    case 'EnCours':
      return Icons.play_arrow;
    case 'Termine':
      return Icons.check_circle;
    default:
      return Icons.help_outline;
  }
}