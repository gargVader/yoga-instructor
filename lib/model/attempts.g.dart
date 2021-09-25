// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attempts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attempt _$AttemptFromJson(Map<String, dynamic> json) {
  return Attempt(
    pose: json['pose'] as String?,
    stars: json['stars'] as int?,
    accuracy: (json['accuracy'] as num?)?.toDouble(),
    dateTime: json['dateTime'] as int?,
    duration: json['duration'] as int?,
    weekday: json['weekday'] as int?,
  );
}

Map<String, dynamic> _$AttemptToJson(Attempt instance) => <String, dynamic>{
      'pose': instance.pose,
      'stars': instance.stars,
      'accuracy': instance.accuracy,
      'dateTime': instance.dateTime,
      'duration': instance.duration,
      'weekday': instance.weekday,
    };
