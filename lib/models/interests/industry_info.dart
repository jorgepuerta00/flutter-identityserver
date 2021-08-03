import 'dart:convert';

class IndustryInfo {
  final String name;
  final String color;
  final String interests;
  final String icon;
  final String id;

  IndustryInfo({
    required this.name,
    required this.color,
    required this.interests,
    required this.icon,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
      'interests': interests,
      'icon': icon,
      'id': id,
    };
  }

  factory IndustryInfo.fromMap(Map<String, dynamic> map) {
    return IndustryInfo(
      name: map['name'],
      color: map['color'],
      interests: map['interests'],
      icon: map['icon'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IndustryInfo.fromJson(String source) =>
      IndustryInfo.fromMap(json.decode(source));
}
