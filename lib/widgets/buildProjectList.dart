import 'package:diallo_mamadou_malal_l3gl_examen/screens/publics/tab/projet_detail_view.dart';
import 'package:flutter/material.dart';
import '../config/constants/fonction.dart';
import '../models/projet_model.dart';

Widget buildProjectList(List<ProjectModel> projets) {

  return ListView.builder(
    itemCount: projets.length,
    itemBuilder: (context, index) {
      final projet = projets[index];
      double progressPercentage = projet.progress ?? 0.0;
      Color priorityColor = getPriorityColor(projet.priority.name);
      IconData statusIcon = getStatusIcon(projet.status.name);
      String formattedDate = projet.endDate.toLocal().toString().split(' ')[0];

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 4,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          leading: CircleAvatar(
            backgroundColor: priorityColor.withOpacity(0.2),
            child: Icon(statusIcon, color: priorityColor),
          ),
          title: Text(
            projet.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.flag, color: priorityColor, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    projet.priority.name,
                    style: TextStyle(color: priorityColor, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LinearProgressIndicator(
                  value: progressPercentage / 100,
                  color: priorityColor,
                  backgroundColor: Colors.grey.shade300,
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${progressPercentage.toStringAsFixed(0)}% terminé',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          trailing: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.red.shade800,
            child: IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
              },
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectDetailScreen(project: projet),
              ),
            );
          },
        ),
      );
    },
  );
}
