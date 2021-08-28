import 'package:json_annotation/json_annotation.dart';

part 'landmarks.g.dart';

@JsonSerializable()
class Landmarks {
  Landmarks({
    this.landmarks,
  });

  List<Landmark>? landmarks;

  factory Landmarks.fromJson(Map<String, dynamic> json) =>
      _$LandmarksFromJson(json);

  Map<String, dynamic> toJson() => _$LandmarksToJson(this);
}

@JsonSerializable()
class Landmark {
  Landmark({
    this.name,
    this.x,
    this.y,
  });

  String? name;
  double? x;
  double? y;

  factory Landmark.fromJson(Map<String, dynamic> json) =>
      _$LandmarkFromJson(json);

  Map<String, dynamic> toJson() => _$LandmarkToJson(this);
}
