import 'dart:convert';

class VerifyCodeInfo {
  VerifyCodeInfo({
    required this.userEmail,
    this.verificationCode,
  });

  final String userEmail;
  final String? verificationCode;

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'verificationCode': verificationCode,
    };
  }

  factory VerifyCodeInfo.fromMap(Map<String, dynamic> map) {
    return VerifyCodeInfo(
      userEmail: map['userEmail'],
      verificationCode: map['verificationCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyCodeInfo.fromJson(String source) =>
      VerifyCodeInfo.fromMap(json.decode(source));

  VerifyCodeInfo copyWith({
    String? userEmail,
    String? verificationCode,
  }) {
    return VerifyCodeInfo(
      userEmail: userEmail ?? this.userEmail,
      verificationCode: verificationCode ?? this.verificationCode,
    );
  }
}
