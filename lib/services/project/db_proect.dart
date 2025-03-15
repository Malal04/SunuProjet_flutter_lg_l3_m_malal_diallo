import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../../models/projet_model.dart';
import '../../models/enums/status.dart';

class DbProjectService {
  final CollectionReference projectCol = FirebaseFirestore.instance.collection("projects");
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<ProjectModel?> getProject(String id) async {
    try {
      final doc = await projectCol.doc(id).get();
      if (!doc.exists) {
        Logger().w("Projet introuvable : $id");
        return null;
      }
      return ProjectModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      Logger().e("Erreur lors de la récupération du projet : $e");
      return null;
    }
  }

  Stream<List<ProjectModel>> getProjectsStreamByStatus(String userId, ProjectStatus status) {
    return _db
        .collection("projects")
        .where("status", isEqualTo: status.name)
        .where(Filter.or(
        Filter("members", arrayContains: userId),
        Filter("createdBy", isEqualTo: userId)
    ))
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ProjectModel.fromMap(doc.data())).toList();
    });
  }

}
