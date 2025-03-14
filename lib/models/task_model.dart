class TaskModel {
  final String id;
  final String projectId;
  final String title;
  final String description;
  final String assignedTo; // ID de l'utilisateur assigné
  final String priority; // "Basse", "Moyenne", "Haute", "Urgente"
  final DateTime dueDate;
  final double completion; // Pourcentage d'avancement (0.0 - 100.0)

  TaskModel({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.priority,
    required this.dueDate,
    required this.completion,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      projectId: map['projectId'],
      title: map['title'],
      description: map['description'],
      assignedTo: map['assignedTo'],
      priority: map['priority'],
      dueDate: DateTime.parse(map['dueDate']),
      completion: map['completion'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'projectId': projectId,
      'title': title,
      'description': description,
      'assignedTo': assignedTo,
      'priority': priority,
      'dueDate': dueDate.toIso8601String(),
      'completion': completion,
    };
  }
}
