class UserModel {
  String? _id;
  String? _nomComplete;
  String? _email;

  String? get id => _id;

  String? get nomComplete => _nomComplete;

  String? get email => _email;


  UserModel({
    required String id,
    required String nomComplete,
    required String email,
  }) {
    _id = id;
    _nomComplete = nomComplete;
    _email = email;
  }
}