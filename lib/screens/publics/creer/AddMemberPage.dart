import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../controllers/ProjectProvider.dart';
import '../../../models/enums/role.dart';
import '../../../models/user_model.dart';

class AddMemberPage extends StatefulWidget {
  final String projectId;
  AddMemberPage({required this.projectId});
  @override
  _AddMemberPageState createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  List<UserModel> _users = [];
  List<UserModel> _selectedUsers = [];

  Future<void> _fetchUsers() async {
    try {

      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();

      setState(() {
        _users = snapshot.docs.map((doc) {
          return UserModel(
            id: doc['id'],
            nom: doc['nom'],
            email: doc['email'],
            role: Role.values.firstWhere(
                  (e) => e.toString().split('.').last == doc['role'],
              orElse: () => Role.admin,
            ),
          );
        }).toList();
      });
    } catch (e) {
      print("Erreur lors de la récupération des utilisateurs : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter des Membres"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Sélectionnez les membres à ajouter au projet :"),
            Expanded(
              child: _users.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_users[index].nom),
                    subtitle: Text(_users[index].email),
                    value: _selectedUsers.contains(_users[index]),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          _selectedUsers.add(_users[index]);
                        } else {
                          _selectedUsers.remove(_users[index]);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: projectProvider.isLoading
                  ? null
                  : () {
                if (_selectedUsers.isNotEmpty) {
                  for (var user in _selectedUsers) {
                    projectProvider.addMember(widget.projectId, user.email!);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Membres ajoutés avec succès !"),
                  ));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Veuillez sélectionner au moins un membre."),
                  ));
                }
              },
              child: projectProvider.isLoading
                  ? CircularProgressIndicator()
                  : Text("Ajouter les Membres"),
            ),

            if (projectProvider.errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  projectProvider.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),

          ],
        ),
      ),
    );
  }
}