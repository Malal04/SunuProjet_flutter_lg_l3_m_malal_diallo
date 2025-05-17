import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/projet_model.dart';
import '../../../controllers/ProjectProvider.dart';
import '../../../widgets/buildMembreList.dart';
import '../../../widgets/buildOverviewTab.dart'; // Import du widget

class ProjectDetailScreen extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailScreen({Key? key, required this.project}) : super(key: key);

  @override
  _ProjectDetailScreenState createState() => _ProjectDetailScreenState();

}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectProvider(),
      child: Consumer<ProjectProvider>(
        builder: (context, projectProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.project.title),
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: "Aperçu"),
                  Tab(text: "Tâches"),
                  Tab(text: "Membres"),
                  Tab(text: "Fichiers"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                buildOverviewTab(widget.project, projectProvider,context),
                const Center(child: Text("Tâches")),
                buildMembreList(widget.project,context),
                const Center(child: Text("Fichiers")),
              ],
            ),
          );
        },
      ),
    );
  }
}
