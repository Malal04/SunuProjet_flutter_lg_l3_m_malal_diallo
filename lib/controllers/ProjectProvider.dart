import 'package:diallo_mamadou_malal_l3gl_examen/models/user_model.dart';
import 'package:diallo_mamadou_malal_l3gl_examen/services/auth/db_user.dart';
import 'package:diallo_mamadou_malal_l3gl_examen/services/project/db_proect.dart';
import 'package:flutter/material.dart';
import '../models/projet_model.dart';
import '../models/enums/status.dart';


class ProjectProvider with ChangeNotifier {
  final DbProjectService _projectService = DbProjectService();
  List<ProjectModel> _projects = [];
  List<ProjectModel> _filteredProjects = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProjectModel> get projects => _projects;
  List<ProjectModel> get filteredProjects => _filteredProjects;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;


  // Fonction pour récupérer un projet par ID
  Future<ProjectModel?> getProjectById(String id) async {
    if (id.isEmpty) {
      _errorMessage = "L'ID du projet ne peut pas être vide.";
      notifyListeners();
      return null;
    }
    try {
      return await _projectService.getProject(id);
    } catch (e) {
      _errorMessage = "Erreur lors de la récupération du projet : $e";
      notifyListeners();
      return null;
    }
  }

  // Récupérer les projets en temps réel selon le statut
  Stream<List<ProjectModel>> getProjectsStream(String userId, ProjectStatus status) {
    return _projectService.getProjectsStreamByStatus(userId, status);
  }

  // Fonction pour rechercher les projets par titre ou description
  void searchProjects(String query) {
    _filteredProjects = _projects.where((project) {
      final titleLower = project.title.toLowerCase();
      final descriptionLower = project.description.toLowerCase();
      final queryLower = query.toLowerCase();
      return titleLower.contains(queryLower) || descriptionLower.contains(queryLower);
    }).toList();
    notifyListeners();
  }

  // Fonction pour mettre à jour le statut d'un projet
  Future<void> updateProjectStatus(String projectId, String status) async {
    if (projectId.isEmpty) {
      _errorMessage = "L'ID du projet ne peut pas être vide.";
      notifyListeners();
      return;
    }
    try {
      await _projectService.updateProjectStatus(projectId, status);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Erreur lors de la mise à jour du statut : $e";
      notifyListeners();
    }
  }

  // Fonction pour mettre à jour la progression d'un projet
  Future<void> updateProjectProgress(String projectId, double progress) async {
    if (projectId.isEmpty) {
      _errorMessage = "L'ID du projet ne peut pas être vide.";
      notifyListeners();
      return;
    }
    try {
      await _projectService.updateProjectProgress(projectId, progress);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Erreur lors de la mise à jour de la progression : $e";
      notifyListeners();
    }
  }


  // Future<void> addMember(String projectId, String userId) async {
  //   try {
  //     _isLoading = true;
  //     notifyListeners();
  //     await _projectService.addMemberToProject(projectId, userId);
  //     _isLoading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     _isLoading = false;
  //     _errorMessage = "Erreur lors de l'ajout du membre : $e";
  //     notifyListeners();
  //   }
  // }

  Future<void> addMember(String projectId, String userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _projectService.addMemberToProject(projectId, userId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = "Erreur lors de l'ajout du membre : $e";
      notifyListeners();
    }
  }

  Future<List<String>> fetchAllUsers() async {
    try {
      return await _projectService.getAllUsers();
    } catch (e) {
      _errorMessage = "Erreur lors de la récupération des utilisateurs : $e";
      notifyListeners();
      return [];
    }
  }

}
