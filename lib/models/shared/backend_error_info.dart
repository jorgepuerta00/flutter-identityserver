import 'dart:convert';

class BackendErrorInfo {
  String title;
  BackendErrorInfo({
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }

  factory BackendErrorInfo.fromMap(Map<String, dynamic> map) {
    return BackendErrorInfo(
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BackendErrorInfo.fromJson(String source) =>
      BackendErrorInfo.fromMap(json.decode(source));
}
