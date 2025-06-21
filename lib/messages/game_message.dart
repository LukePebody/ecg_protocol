import 'package:json_annotation/json_annotation.dart';
import '../models/card_data.dart';

part 'game_message.g.dart';

@JsonSerializable()
class GameMessage {
  final String type;
  final Map<String, dynamic> data;
  final String? playerId;
  final DateTime timestamp;

  GameMessage({
    required this.type,
    required this.data,
    this.playerId,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory GameMessage.fromJson(Map<String, dynamic> json) =>
      _$GameMessageFromJson(json);
  Map<String, dynamic> toJson() => _$GameMessageToJson(this);

  // Factory constructors for common message types
  factory GameMessage.cardData(List<CardData> cards, {String? playerId}) {
    return GameMessage(
      type: 'card_data',
      data: {'cards': cards.map((c) => c.toJson()).toList()},
      playerId: playerId,
    );
  }

  factory GameMessage.gameState(Map<String, dynamic> state,
      {String? playerId}) {
    return GameMessage(
      type: 'game_state',
      data: state,
      playerId: playerId,
    );
  }

  factory GameMessage.playerAction(
      String action, Map<String, dynamic> actionData,
      {String? playerId}) {
    return GameMessage(
      type: 'player_action',
      data: {'action': action, ...actionData},
      playerId: playerId,
    );
  }

  factory GameMessage.heartbeat({String? playerId}) {
    return GameMessage(
      type: 'heartbeat',
      data: {},
      playerId: playerId,
    );
  }
}
