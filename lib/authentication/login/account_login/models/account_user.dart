class EmailUserModel {
  final String userId;
  final String email;
  final String username;
  final String? profileImageURL; // Make it optional

  EmailUserModel({
    required this.userId,
    required this.email,
    required this.username,
    this.profileImageURL,
  });
}
