import 'dart:convert';

class ResetPasswordInfo {
  ResetPasswordInfo({
    required this.userEmail,
    required this.password,
  });

  final String userEmail;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'password': password,
    };
  }

  factory ResetPasswordInfo.fromMap(Map<String, dynamic> map) {
    return ResetPasswordInfo(
      userEmail: map['userEmail'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordInfo.fromJson(String source) =>
      ResetPasswordInfo.fromMap(json.decode(source));
}
