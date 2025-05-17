import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diallo_mamadou_malal_l3gl_examen/screens/publics/accuiel_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../config/constants/constants_assets.dart';
import '../../../config/constants/constants_color.dart';
import '../../../models/projet_model.dart';
import '../../../models/enums/status.dart';
import '../../../models/enums/priority.dart';

class CreerProjet extends StatefulWidget {
  static const String routeName = '/creer';
  const CreerProjet({super.key});

  @override
  State<CreerProjet> createState() => _CreerProjetState();
}

class _CreerProjetState extends State<CreerProjet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateDebutController = TextEditingController();
  final TextEditingController _dateFinController = TextEditingController();
  String? _prioriteSelectionnee = "Moyenne";
  final List<String> _priorites = ["Basse", "Moyenne", "Haute", "Urgente"];
  bool isLoading = false;

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2035),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  Future<void> _creerProject() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String userId = FirebaseAuth.instance.currentUser!.uid;

      ProjectPriority priorityEnum = ProjectPriority.values.firstWhere((e) => e.name == _prioriteSelectionnee);

      ProjectModel newProject = ProjectModel(
        id: '',
        title: _titreController.text,
        description: _descriptionController.text,
        startDate: DateFormat('dd/MM/yyyy').parse(_dateDebutController.text),
        endDate: DateFormat('dd/MM/yyyy').parse(_dateFinController.text),
        priority: priorityEnum,
        status: ProjectStatus.EnAttente,
        createdBy:userId,
        memberIds:[],
      );

      try {
        await FirebaseFirestore.instance.collection('projects').add(newProject.toMap());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Projet créé avec succès!")),
        );

        _formKey.currentState!.reset();
        setState(() {
          _titreController.clear();
          _descriptionController.clear();
          _dateDebutController.clear();
          _dateFinController.clear();
          _prioriteSelectionnee = "Moyenne";
          isLoading = false;
        });

        Navigator.pushReplacementNamed(context, AccueilScreen.routeName);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de la création du projet: $e")),
        );

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Créer un projet",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(kAppProfil),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titreController,
                  decoration: InputDecoration(
                    labelText: 'Titre du projet',
                    prefixIcon: const Icon(Icons.text_fields, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: kSecondaryColor, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un titre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    prefixIcon: const Icon(Icons.description, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: kSecondaryColor, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  "Dates du projet",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dateDebutController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date de début',
                          prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: kSecondaryColor, width: 2),
                          ),
                        ),
                        onTap: () => _selectDate(context, _dateDebutController),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez sélectionner une date';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _dateFinController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date de fin',
                          prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: kSecondaryColor, width: 2),
                          ),
                        ),
                        onTap: () => _selectDate(context, _dateFinController),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez sélectionner une date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  "Priorité",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: _priorites.map((priorite) {
                        return RadioListTile<String>(
                          title: Text(
                            priorite,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          value: priorite,
                          groupValue: _prioriteSelectionnee,
                          onChanged: (String? newValue) {
                            setState(() {
                              _prioriteSelectionnee = newValue;
                            });
                          },
                          activeColor: kSecondaryColor,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _creerProject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Créer le projet", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
