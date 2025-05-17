import 'package:flutter/material.dart';
import '../../../models/projet_model.dart';
import '../controllers/ProjectProvider.dart';
import '../models/enums/status.dart';

bool isLoading = false;


Widget buildOverviewTab(ProjectModel project, ProjectProvider projectProvider,BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProjectDetailsCard(project),
          const SizedBox(height: 15),
          _buildProjectProgressCard(project, projectProvider,context),
        ],
      ),
    ),
  );
}

Widget _buildProjectDetailsCard(ProjectModel project) {
  return Card(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    color: Colors.white,
    shadowColor: Colors.grey.withOpacity(0.3),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProjectHeader(project),
          const SizedBox(height: 5),
          _buildPriorityText(project),
          const SizedBox(height: 10),
          _buildDescriptionText(project),
          const SizedBox(height: 12),
          _buildProjectDateRange(project),
        ],
      ),
    ),
  );
}

Widget _buildProjectHeader(ProjectModel project) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          project.title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      Chip(
        label: Text(
          project.status.name,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: getStatusColor(project.status),
      ),
    ],
  );
}

Widget _buildPriorityText(ProjectModel project) {
  return Text(
    "🔸Priorité: ${project.priority.name}",
    style: const TextStyle(
      color: Colors.redAccent,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  );
}

Widget _buildDescriptionText(ProjectModel project) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Description",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      const SizedBox(height: 5),
      Text(
        project.description,
        style: const TextStyle(fontSize: 14, color: Colors.black54),
      ),
    ],
  );
}

Widget _buildProjectDateRange(ProjectModel project) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Dates",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      const SizedBox(height: 5),
      Row(
        children: [
          const Icon(Icons.calendar_today, size: 18),
          const SizedBox(width: 5),
          Text(
            "Début: ${project.startDate.toLocal().toString().split(' ')[0]}",
            style: const TextStyle(color: Colors.black87),
          ),
          const SizedBox(width: 20),
          const Icon(Icons.calendar_today, size: 18),
          const SizedBox(width: 5),
          Text(
            "Fin: ${project.endDate.toLocal().toString().split(' ')[0]}",
            style: const TextStyle(color: Colors.black87),
          ),
        ],
      ),
    ],
  );
}

Widget _buildProgressIndicator(ProjectModel project) {
  return Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 130,
          height: 130,
          child: CircularProgressIndicator(
            value: project.progress / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(getProgressColor(project.progress)),
            strokeWidth: 12,
          ),
        ),
        Text(
          "${project.progress.toInt()}%",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    ),
  );
}




Widget _buildProjectProgressCard(ProjectModel project, ProjectProvider projectProvider, BuildContext context) {
  return Card(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    color: Colors.white,
    shadowColor: Colors.grey.withOpacity(0.3),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Avancement du projet",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 15),
          _buildProgressIndicator(project),
          const SizedBox(height: 25),
          const Text(
            "Changer le statut du projet",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 15),
          _buildStatusButtons(project, projectProvider,context),
        ],
      ),
    ),
  );
}
Widget _buildStatusButtons(ProjectModel project, ProjectProvider projectProvider, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      buildStatusButton("En attente", Colors.orange, projectProvider, project, context),
      buildStatusButton("En cours", Colors.blue, projectProvider, project, context),
      buildStatusButton("Terminé", Colors.green, projectProvider, project, context),
      buildStatusButton("Annulé", Colors.red, projectProvider, project, context),
    ],
  );
}
Widget buildStatusButton(
    String status, Color color,ProjectProvider projectProvider, ProjectModel project,
    BuildContext context
    ) {
  bool isLoading = false;
  bool isCurrentStatus = project.status.name == status;

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: isCurrentStatus ? Colors.grey : color, // Désactive le bouton actif
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      elevation: isCurrentStatus ? 0 : 3,
    ),
    onPressed: isCurrentStatus ? null : () async {
      if (isLoading) return;
      isLoading = true;
      ProjectStatus newStatus = project.status;
      double newProgress = project.progress;
      if (project.status == ProjectStatus.Termine) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Le projet est déjà terminé et ne peut pas être modifié.")),
        );
        return;
      }
      if (project.status == ProjectStatus.EnAttente || project.status == ProjectStatus.Annule) {
        newStatus = ProjectStatus.EnCours;
        newProgress = 50.0;
      } else if (project.status == ProjectStatus.EnCours && status == "Terminé") {
        newStatus = ProjectStatus.Termine;
        newProgress = 100.0;
      } else if (project.status == ProjectStatus.EnCours && status == "Annulé") {
        newStatus = ProjectStatus.Annule;
        newProgress = 0.0;
      }
      try {
        await projectProvider.updateProjectStatus(project.id, newStatus.name);
        await projectProvider.updateProjectProgress(project.id, newProgress);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Statut mis à jour : ${newStatus.name}")),
        );
      } catch (e) {
        debugPrint("Erreur lors de la mise à jour du statut : $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erreur: Impossible de mettre à jour le statut")),
        );
      } finally {
        isLoading = false;
      }
    },
    child: isLoading
        ? const SizedBox(
      width: 15,
      height: 15,
      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
    )
        : Text(status, style: const TextStyle(color: Colors.white)),
  );
}




Color getStatusColor(ProjectStatus status) {
  switch (status) {
    case ProjectStatus.EnAttente:
      return Colors.orange;
    case ProjectStatus.EnCours:
      return Colors.blue;
    case ProjectStatus.Termine:
      return Colors.green;
    case ProjectStatus.Annule:
      return Colors.red;
    default:
      return Colors.grey;
  }
}

Color getProgressColor(double progress) {
  if (progress == 100) {
    return Colors.green;
  } else if (progress >= 50) {
    return Colors.blue;
  } else {
    return Colors.orange;
  }
}