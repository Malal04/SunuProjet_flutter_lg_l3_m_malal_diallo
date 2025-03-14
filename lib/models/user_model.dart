

import 'enums/role.dart';

class UserModel {
  final String id;
  final String nom;
  final String email;
  final Role role;
  final String? profilePicture;
  final bool isActive;

  UserModel({
    required this.id,
    required this.nom,
    required this.email,
    this.role = Role.admin, // Par défaut, l'utilisateur est un admin
    this.profilePicture,
    this.isActive = true,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nom: map['nom'],
      email: map['email'],
      role: Role.values.firstWhere(
            (e) => e.toString().split('.').last == map['role'],
        orElse: () => Role.admin, // Valeur par défaut
      ),
      profilePicture: map['profilePicture'],
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'email': email,
      'role': role.toString().split('.').last, // Stocké sous forme de string
      'profilePicture': profilePicture,
      'isActive': isActive,
    };
  }
}
