import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class User {
  User({
    required this.email,
    required this.password,
    required this.username,
  });

  String? email;
  String? password;
  String? username;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
