class Project {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String priority; // "Basse", "Moyenne", "Haute", "Urgente"
  final String status; // "En attente", "En cours", "Terminé", "Annulé"
  final List<String> members; // Liste des IDs des utilisateurs

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.priority,
    required this.status,
    required this.members,
  });

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      priority: map['priority'],
      status: map['status'],
      members: List<String>.from(map['members']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'priority': priority,
      'status': status,
      'members': members,
    };
  }
}
