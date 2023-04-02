import 'package:baby_guard/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'read_user_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class ReadUserResponse {
  ReadUserResponse({
    required this.user,
  });

  final User? user;

  factory ReadUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ReadUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReadUserResponseToJson(this);
}
