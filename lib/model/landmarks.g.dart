// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landmarks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Landmarks _$LandmarksFromJson(Map<String, dynamic> json) {
  return Landmarks(
    landmarks: (json['landmarks'] as List<dynamic>?)
        ?.map((e) => Landmark.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LandmarksToJson(Landmarks instance) => <String, dynamic>{
      'landmarks': instance.landmarks,
    };

Landmark _$LandmarkFromJson(Map<String, dynamic> json) {
  return Landmark(
    name: json['name'] as String?,
    x: (json['x'] as num?)?.toDouble(),
    y: (json['y'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$LandmarkToJson(Landmark instance) => <String, dynamic>{
      'name': instance.name,
      'x': instance.x,
      'y': instance.y,
    };
