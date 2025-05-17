import 'package:diallo_mamadou_malal_l3gl_examen/models/enums/Type.dart';

class Transaction {
  final String? id;
  final String montant;
  final DateTime date;
  final String description;
  final String categorie_id;
  final TypeTransaction type;
  final String user_id;


  Transaction({
    required this.id,
    required this.montant,
    required this.date,
    required this.description,
    required this.categorie_id,
    required this.type,
    required this.user_id,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
        id: map['id'],
        montant: map['montant'],
        date: map['date'],
        description: map['description'],
        categorie_id: map['categorie_id'],
        type: map['type'],
        user_id: map['user_id']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'montant': montant,
      'date': date,
      'description': description,
      'categorie_id': categorie_id,
      'type': type,
      'user_id': user_id
    };
  }
}
