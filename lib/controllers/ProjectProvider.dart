import 'package:flutter/material.dart';
import '../models/projet_model.dart';
import '../models/enums/status.dart';
import '../services/project/db_proect.dart';

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
  /// Récupère un projet par son ID
  Future<ProjectModel?> getProjectById(String id) async {
    try {
      return await _projectService.getProject(id);
    } catch (e) {
      _errorMessage = "Erreur lors de la récupération du projet : $e";
      notifyListeners();
      return null;
    }
  }
  /// Récupération des projets en temps réel selon le statut
  Stream<List<ProjectModel>> getProjectsStream(String userId, ProjectStatus status) {
    return _projectService.getProjectsStreamByStatus(userId, status);
  }
  void searchProjects(String query) {
    _filteredProjects = _projects.where((project) {
      final titleLower = project.title.toLowerCase();
      final descriptionLower = project.description.toLowerCase();
      final queryLower = query.toLowerCase();
      return titleLower.contains(queryLower) || descriptionLower.contains(queryLower);
    }).toList();
    notifyListeners();
  }

}
