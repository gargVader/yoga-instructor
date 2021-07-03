import 'package:json_annotation/json_annotation.dart';

part 'attempts.g.dart';

@JsonSerializable()
class Attempt {
  String pose;
  int stars;
  double accuracy;
  int dateTime;
  int duration;
  int weekday;

  Attempt({
    this.pose,
    this.stars,
    this.accuracy,
    this.dateTime,
    this.duration,
    this.weekday,
  });

  factory Attempt.fromJson(Map<String, dynamic> json) =>
      _$AttemptFromJson(json);

  Map<String, dynamic> toJson() => _$AttemptToJson(this);
}
