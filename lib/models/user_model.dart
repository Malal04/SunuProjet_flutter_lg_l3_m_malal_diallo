import 'enums/role.dart';

class UserModel {
  final String? id;
  final String nom;
  final String email;
  final Role role;
  final String? profilePicture;
  final bool isActive;

  UserModel({
    required this.id,
    required this.nom,
    required this.email,
    this.role = Role.admin,
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
        orElse: () => Role.admin,
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
      'role': role.toString().split('.').last,
      'profilePicture': profilePicture,
      'isActive': isActive,
    };
  }

}
