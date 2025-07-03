// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gin_rummy_game_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GinRummyGameMessage _$GinRummyGameMessageFromJson(Map<String, dynamic> json) =>
    GinRummyGameMessage(
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>,
      playerId: json['playerId'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$GinRummyGameMessageToJson(
        GinRummyGameMessage instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'playerId': instance.playerId,
      'timestamp': instance.timestamp.toIso8601String(),
    };
