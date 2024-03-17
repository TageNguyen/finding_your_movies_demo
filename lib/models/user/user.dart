import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;

  final String email;

  final String avatarUrl;

  final String phoneNumber;

  User({this.id = '', this.email = '', this.avatarUrl = '', this.phoneNumber = ''});

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
