import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../config/constants/constants_assets.dart';
import '../../../config/constants/constants_color.dart';

class CreerProjet extends StatefulWidget {
  static const String routeName = '/creer';
  const CreerProjet({super.key});

  @override
  State<CreerProjet> createState() => _CreerProjetState();
}

class _CreerProjetState extends State<CreerProjet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titreController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateDebutController = TextEditingController();
  TextEditingController _dateFinController = TextEditingController();

  String? _prioriteSelectionnee = "Moyenne";
  final List<String> _priorites = ["Basse", "Moyenne", "Haute", "Urgente"];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Créer un projet",
          style: TextStyle(color: Colors.white, fontSize: 20),
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
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titreController,
                  decoration: InputDecoration(
                    labelText: 'Titre du projet',
                    prefixIcon: Icon(Icons.text_fields),
                    border: OutlineInputBorder(),
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
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    )
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dateDebutController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date de début',
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
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
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    )
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: _priorites.map((priorite) {
                        return RadioListTile<String>(
                          title: Text(priorite),
                          value: priorite,
                          groupValue: _prioriteSelectionnee,
                          onChanged: (String? newValue) {
                            setState(() {
                              _prioriteSelectionnee = newValue;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Bouton de soumission
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Projet créé avec succès!")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Créer le projet"),
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