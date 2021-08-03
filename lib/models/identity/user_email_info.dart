import 'dart:convert';

class UserEmailInfo {
  UserEmailInfo({
    required this.userEmail,
  });

  final String userEmail;

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
    };
  }

  factory UserEmailInfo.fromMap(Map<String, dynamic> map) {
    return UserEmailInfo(
      userEmail: map['userEmail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEmailInfo.fromJson(String source) =>
      UserEmailInfo.fromMap(json.decode(source));
}
