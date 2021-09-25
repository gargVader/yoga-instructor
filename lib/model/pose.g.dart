// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pose.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pose _$PoseFromJson(Map<String, dynamic> json) {
  return Pose(
    title: json['title'] as String?,
    sub: json['sub'] as String?,
    image: json['image'] as String?,
    hash: json['hash'] as String?,
    benefits: json['benefits'] as String?,
    videoUrl: json['video_url'] as String?,
    pausePoints:
        (json['pause_points'] as List<dynamic>?)?.map((e) => e as int).toList(),
    index: (json['index'] as List<dynamic>?)?.map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$PoseToJson(Pose instance) => <String, dynamic>{
      'title': instance.title,
      'sub': instance.sub,
      'benefits': instance.benefits,
      'image': instance.image,
      'hash': instance.hash,
      'video_url': instance.videoUrl,
      'pause_points': instance.pausePoints,
      'index': instance.index,
    };
