import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class User {
  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.password,
    required this.username,
  });

  int? id;
  String? updatedAt;
  String? createdAt;
  String? email;
  String? password;
  String? username;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
