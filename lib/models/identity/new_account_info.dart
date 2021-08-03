import 'dart:convert';

import 'package:equatable/equatable.dart';

class NewAccountInfo extends Equatable {
  NewAccountInfo({
    required this.userEmail,
    required this.password,
  });

  final String userEmail;
  final String password;

  NewAccountInfo copyWith({
    String? email,
    String? password,
  }) {
    return NewAccountInfo(
      userEmail: email ?? this.userEmail,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'password': password,
    };
  }

  factory NewAccountInfo.fromMap(Map<String, dynamic> map) {
    return NewAccountInfo(
      userEmail: map['userEmail'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewAccountInfo.fromJson(String source) =>
      NewAccountInfo.fromMap(json.decode(source));

  @override
  List<Object?> get props => [userEmail, password];

  @override
  bool get stringify => true;
}
