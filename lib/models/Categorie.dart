class Categorie {
  final String? id;
  final String libelle;


  Categorie({
    required this.id,
    required this.libelle,
  });

  factory Categorie.fromMap(Map<String, dynamic> map) {
    return Categorie(
        id: map['id'],
        libelle: map['libelle'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'montant': libelle,
    };
  }
}
