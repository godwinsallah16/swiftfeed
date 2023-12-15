// user_model.dart
class AnonUserModel {
  final String userId;
  final bool isAnonymous;
  final String? email; // Make email parameter nullable

  AnonUserModel({
    required this.userId,
    required this.isAnonymous,
    this.email,
  });
}
