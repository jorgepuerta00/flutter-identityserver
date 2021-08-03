import 'dart:convert';

class LocationInfo {
  LocationInfo({
    required this.name,
    required this.id,
  });

  final String name;
  final String id;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory LocationInfo.fromMap(Map<String, dynamic> map) {
    return LocationInfo(
      name: map['name'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationInfo.fromJson(String source) =>
      LocationInfo.fromMap(json.decode(source));
}
