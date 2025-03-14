class FileModel {
  final String id;
  final String projectId;
  final String fileName;
  final String fileUrl;
  final String uploadedBy; // ID de l'utilisateur
  final DateTime uploadedAt;
  final int fileSize; // Taille en Ko ou Mo

  FileModel({
    required this.id,
    required this.projectId,
    required this.fileName,
    required this.fileUrl,
    required this.uploadedBy,
    required this.uploadedAt,
    required this.fileSize,
  });

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      id: map['id'],
      projectId: map['projectId'],
      fileName: map['fileName'],
      fileUrl: map['fileUrl'],
      uploadedBy: map['uploadedBy'],
      uploadedAt: DateTime.parse(map['uploadedAt']),
      fileSize: map['fileSize'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'projectId': projectId,
      'fileName': fileName,
      'fileUrl': fileUrl,
      'uploadedBy': uploadedBy,
      'uploadedAt': uploadedAt.toIso8601String(),
      'fileSize': fileSize,
    };
  }
}
