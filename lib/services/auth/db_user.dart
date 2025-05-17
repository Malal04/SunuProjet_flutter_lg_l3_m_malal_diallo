import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diallo_mamadou_malal_l3gl_examen/models/user_model.dart';
import 'package:logger/logger.dart';

class DbUserService {
  final CollectionReference userCol = FirebaseFirestore.instance.collection("users");

  Future<void> saveUser(UserModel user) async {
    try{
      await userCol.doc(user.id).set(user.toMap());
    }catch(e){
      Logger().e("Erreur lors de l'enregistrement sur FirebaseFirestore: ${e}");
    }
  }

  Future<UserModel?> getUser(String id) async {
    try {
      final doc = await userCol.doc(id).get(); // Récupérer le document

      if (!doc.exists) {
        Logger().w("Utilisateur introuvable avec l'ID: $id");
        return null;
      }

      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) return null;

      return UserModel.fromMap(data);
    } catch (e) {
      Logger().e("Erreur lors de la récupération de l'utilisateur: $e");
      return null;
    }
  }

  // Récupérer un utilisateur par email
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final snapshot = await userCol.where('email', isEqualTo: email).get();
      if (snapshot.docs.isEmpty) {
        return null; // Aucun utilisateur trouvé avec cet email
      }
      final userDoc = snapshot.docs.first;
      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Erreur lors de la récupération de l'utilisateur : $e");
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await userCol.doc(userId).get();
      if (!doc.exists) {
        return null; // Aucun utilisateur trouvé avec cet ID
      }
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Erreur lors de la récupération de l'utilisateur : $e");
    }
  }


}
