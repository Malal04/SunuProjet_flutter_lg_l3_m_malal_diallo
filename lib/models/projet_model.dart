import 'dart:convert';
import 'enums/priority.dart';
import 'enums/status.dart';

class ProjectModel {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final ProjectPriority priority;
  final ProjectStatus status;
  final List<String> members;
  final String createdBy; // Utilisateur qui a ajouté le projet
  final double progress; // Progression automatique basée sur le statut

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.priority,
    required this.status,
    required this.members,
    required this.createdBy,
  })  : progress = _calculateProgress(status) { // Calcul automatique
    if (startDate.isAfter(endDate)) {
      throw ArgumentError('La date de début ne peut pas être après la date de fin.');
    }
  }

  /// Fonction pour calculer la progression en fonction du statut
  static double _calculateProgress(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.EnAttente: // En attente
        return 0.0;
      case ProjectStatus.EnCours: // En cours
        return 50.0;
      case ProjectStatus.Termine: // Terminé
        return 100.0;
      default:
        return 0.0;
    }
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      priority: ProjectPriority.values.firstWhere((e) => e.name == map['priority']),
      status: ProjectStatus.values.firstWhere((e) => e.name == map['status']),
      members: List<String>.from(map['members']),
      createdBy: map['createdBy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'priority': priority.name,
      'status': status.name,
      'members': members,
      'createdBy': createdBy,
      'progress': progress, // Ajout de la progression
    };
  }

  factory ProjectModel.fromJson(String source) => ProjectModel.fromMap(json.decode(source));
  String toJson() => json.encode(toMap());
}
