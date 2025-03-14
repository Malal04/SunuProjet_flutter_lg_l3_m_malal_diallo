class NotificationModel {
  final String id;
  final String userId; // Destinataire
  final String message;
  final String type; // "Projet", "Tâche", "Système"
  final DateTime timestamp;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      userId: map['userId'],
      message: map['message'],
      type: map['type'],
      timestamp: DateTime.parse(map['timestamp']),
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'message': message,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }
}
