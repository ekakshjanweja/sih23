import 'dart:convert';

class SpamModel {
  final bool spam;
  final int? department;

  SpamModel({
    required this.spam,
    required this.department,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'spam': spam,
      'department': department,
    };
  }

  factory SpamModel.fromMap(Map<String, dynamic> map) {
    return SpamModel(
      spam: map['spam'] as bool,
      department: map['department'] != null ? map['department'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpamModel.fromJson(String source) =>
      SpamModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
