import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class MyUser {
  MyUser({
    this.uid,
    this.email,
    this.imageUrl,
    this.accountName,
    this.userName,
    this.gender,
    this.age,
    this.stars,
    this.accuracy,
    this.time,
  });

  String? uid;
  String? email;
  String? imageUrl;
  String? accountName;
  String? userName;
  String? gender;
  String? age;
  int? stars;
  double? accuracy;
  int? time;

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}
