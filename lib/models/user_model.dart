class UserModel {
  final String name;
  final String uid;
  final String phone;

  UserModel({
    required this.name,
    required this.uid,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      uid: map['uid'],
      phone: map['phone'],
    );
  }
}
