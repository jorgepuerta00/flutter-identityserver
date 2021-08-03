import 'dart:convert';

class SignUpInfo {
  String userEmail;
  String lastName;
  String firstName;
  String dob;
  List<String> idsIndustries;
  String pronoun;
  bool pronounVisibility;
  bool pushNotifications;
  String locationName;

  SignUpInfo({
    required this.userEmail,
    required this.lastName,
    required this.firstName,
    required this.dob,
    required this.idsIndustries,
    required this.pronoun,
    required this.pronounVisibility,
    required this.pushNotifications,
    required this.locationName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'lastName': lastName,
      'firstName': firstName,
      'dob': dob,
      'idsIndustries': idsIndustries,
      'pronoun': pronoun,
      'pronounVisibility': pronounVisibility,
      'pushNotifications': pushNotifications,
      'locationName': locationName,
    };
  }

  factory SignUpInfo.fromMap(Map<String, dynamic> map) {
    return SignUpInfo(
      userEmail: map['userEmail'],
      lastName: map['lastName'],
      firstName: map['firstName'],
      dob: map['dob'],
      idsIndustries: List<String>.from(map['idsIndustries']),
      pronoun: map['pronoun'],
      pronounVisibility: map['pronounVisibility'],
      pushNotifications: map['pushNotifications'],
      locationName: map['locationName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpInfo.fromJson(String source) =>
      SignUpInfo.fromMap(json.decode(source));
}
