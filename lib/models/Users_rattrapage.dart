
class UsersRattrapage {
  final String? id;
  final String nom;
  final String prenom;
  final String email;
  final String tel;
  final String solde;
  final String code_secret;


  UsersRattrapage({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.tel,
    required this.solde,
    required this.code_secret,
  });

  factory UsersRattrapage.fromMap(Map<String, dynamic> map) {
    return UsersRattrapage(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      tel: map['tel'],
      solde: map['solde'],
      code_secret: map['code_secret']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'tel': tel,
      'solde': solde,
      'code_secret': code_secret
    };
  }
}
