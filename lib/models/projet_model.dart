import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final List<String> memberIds;
  final String createdBy;
  final double progress;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.priority,
    required this.status,
    required this.memberIds,
    required this.createdBy,
  })  : progress = _calculateProgress(status) {
    if (startDate.isAfter(endDate)) {
      throw ArgumentError('La date de début ne peut pas être après la date de fin.');
    }
  }

  static double _calculateProgress(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.EnAttente:
        return 0.0;
      case ProjectStatus.EnCours:
        return 50.0;
      case ProjectStatus.Termine:
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
      memberIds: List<String>.from(map['members']),
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
      'members': memberIds,
      'createdBy': createdBy,
      'progress': progress,
    };
  }

  factory ProjectModel.fromJson(String source) => ProjectModel.fromMap(json.decode(source));
  String toJson() => json.encode(toMap());
}
