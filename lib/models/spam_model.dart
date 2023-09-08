import 'dart:convert';

class SpamModel {
  final bool spam;
  final String probability;

  SpamModel({
    required this.spam,
    required this.probability,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'spam': spam,
      'probability': probability,
    };
  }

  factory SpamModel.fromMap(Map<String, dynamic> map) {
    return SpamModel(
      spam: map['spam'] as bool,
      probability: map['probability'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpamModel.fromJson(String source) => SpamModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
