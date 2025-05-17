import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../../models/projet_model.dart';
import '../../models/enums/status.dart';

class DbProjectService {
  final CollectionReference projectCol = FirebaseFirestore.instance.collection("projects");
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // // Fonction pour récupérer un projet à partir de son ID
  // Future<ProjectModel?> getProject(String id) async {
  //   if (id.isEmpty) {
  //     Logger().e("L'ID du projet ne peut pas être vide.");
  //     return null;
  //   }
  //   try {
  //     final doc = await projectCol.doc(id).get();
  //     if (!doc.exists) {
  //       Logger().w("Projet introuvable : $id");
  //       return null;
  //     }
  //     return ProjectModel.fromMap(doc.data() as Map<String, dynamic>);
  //   } catch (e) {
  //     Logger().e("Erreur lors de la récupération du projet : $e");
  //     return null;
  //   }
  // }

  // Fonction pour récupérer les projets en temps réel par statut
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
      return snapshot.docs.map((doc) => ProjectModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  // Fonction pour mettre à jour le statut d'un projet
  Future<void> updateProjectStatus(String projectId, String status) async {
    if (projectId.isEmpty) {
      throw Exception("L'ID du projet ne peut pas être vide.");
    }
    try {
      await projectCol.doc(projectId).update({'status': status});
    } catch (e) {
      throw Exception("Erreur lors de la mise à jour du statut du projet : $e");
    }
  }

  // Fonction pour mettre à jour la progression d'un projet
  Future<void> updateProjectProgress(String projectId, double progress) async {
    if (projectId.isEmpty) {
      throw Exception("L'ID du projet ne peut pas être vide.");
    }
    try {
      await projectCol.doc(projectId).update({'progress': progress});
    } catch (e) {
      throw Exception("Erreur lors de la mise à jour de la progression : $e");
    }
  }

  // Fonction pour récupérer un projet à partir de son ID
  Future<ProjectModel?> getProject(String projectId) async {
    try {
      final doc = await projectCol.doc(projectId).get();
      if (!doc.exists) {
        return null;
      }
      return ProjectModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Erreur lors de la récupération du projet : $e");
    }
  }

  // Mettre à jour les membres du projet
  Future<void> updateProjectMembers(String projectId, List<String> members) async {
    try {
      await projectCol.doc(projectId).update({
        'members': members,
      });
    } catch (e) {
      throw Exception("Erreur lors de la mise à jour des membres du projet : $e");
    }
  }

  // // Ajouter un membre par ID
  // Future<void> addMemberToProject(String projectId, String userId) async {
  //   try {
  //     final projectDoc = await projectCol.doc(projectId).get();
  //     if (projectDoc.exists) {
  //       var project = ProjectModel.fromMap(projectDoc.data() as Map<String, dynamic>);
  //       if (!project.memberIds.contains(userId)) {
  //         project.memberIds.add(userId);
  //         await projectCol.doc(projectId).update({'members': project.memberIds});
  //       }
  //     }
  //   } catch (e) {
  //     throw Exception("Erreur lors de l'ajout du membre : $e");
  //   }
  // }

  Future<void> addMemberToProject(String projectId, String userId) async {
    try {
      final projectRef = _db.collection('projects').doc(projectId);

      // Ajouter l'ID du membre à la liste des membres dans Firestore
      await projectRef.update({
        'members': FieldValue.arrayUnion([userId]),
      });
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout du membre au projet : $e');
    }
  }

  // Récupérer tous les utilisateurs (exemple avec Firebase Authentication)
  Future<List<String>> getAllUsers() async {
    try {
      final usersSnapshot = await _db.collection('users').get();
      return usersSnapshot.docs.map((doc) => doc['email'] as String).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des utilisateurs : $e');
    }
  }

}
