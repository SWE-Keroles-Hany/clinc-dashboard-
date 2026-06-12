/// Model for forgot password requests and responses
class ForgotPasswordModel {
  final String email;
  final String? code;
  final String? newPassword;
  final String? confirmPassword;

  ForgotPasswordModel({
    required this.email,
    this.code,
    this.newPassword,
    this.confirmPassword,
  });

  /// Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    if (code != null) data['code'] = code;
    if (newPassword != null) data['newPassword'] = newPassword;
    if (confirmPassword != null) data['confirmPassword'] = confirmPassword;
    return data;
  }

  /// Factory constructor for creating from JSON
  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      email: json['email'] ?? '',
      code: json['code'],
      newPassword: json['newPassword'],
      confirmPassword: json['confirmPassword'],
    );
  }
}
