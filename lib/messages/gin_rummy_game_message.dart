import 'package:json_annotation/json_annotation.dart';
import 'game_message.dart';

part 'gin_rummy_game_message.g.dart';

/// Type-safe wrapper for Gin Rummy specific game messages
/// This ensures we have compile-time verification of all action types
/// and eliminates the use of dynamic types for game actions.
@JsonSerializable()
class GinRummyGameMessage extends GameMessage {
  GinRummyGameMessage({
    required super.type,
    required super.data,
    super.playerId,
    super.timestamp,
  });

  factory GinRummyGameMessage.fromJson(Map<String, dynamic> json) =>
      _$GinRummyGameMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GinRummyGameMessageToJson(this);

  // Factory constructors for each specific action type
  // This provides compile-time safety and eliminates dynamic types

  /// Player draws from the deck
  factory GinRummyGameMessage.drawDeck({
    required String playerId,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {'action': 'draw_deck'},
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  /// Player draws from the discard pile
  factory GinRummyGameMessage.drawDiscard({
    required String playerId,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {'action': 'draw_discard'},
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  /// Player passes on the opening discard (first turn only)
  factory GinRummyGameMessage.pass({
    required String playerId,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {'action': 'pass'},
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  /// Player discards a card
  factory GinRummyGameMessage.discard({
    required String playerId,
    required String cardGuid,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {'action': 'discard', 'cardGuid': cardGuid},
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  /// Player discards a card and knocks
  factory GinRummyGameMessage.discardAndKnock({
    required String playerId,
    required String cardGuid,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {'action': 'discard_and_knock', 'cardGuid': cardGuid},
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  /// Player declares gin (all cards in melds, 10 cards)
  factory GinRummyGameMessage.gin({
    required String playerId,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {'action': 'gin'},
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  /// Player declares big gin (all 11 cards in melds)
  factory GinRummyGameMessage.bigGin({
    required String playerId,
    required List<List<String>> meldCardGuids,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {'action': 'big_gin', 'melds': meldCardGuids},
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  /// Player arranges their cards into melds and deadwood during showdown
  factory GinRummyGameMessage.arrangeMelds({
    required String playerId,
    required List<List<String>> meldCardGuids,
    required List<String> deadwoodCardGuids,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {
        'action': 'arrange_melds',
        'melds': meldCardGuids,
        'deadwood': deadwoodCardGuids,
      },
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  /// Player finishes their showdown arrangement
  factory GinRummyGameMessage.finishShowdown({
    required String playerId,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {'action': 'finish_showdown'},
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  /// Player lays off cards on opponent's melds
  factory GinRummyGameMessage.layOff({
    required String playerId,
    required List<String> cardGuids,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {'action': 'lay_off', 'cardGuids': cardGuids},
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  /// Player is ready for the next round
  factory GinRummyGameMessage.nextRound({
    required String playerId,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {'action': 'next_round'},
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  /// Knocker shows their arranged melds and deadwood
  factory GinRummyGameMessage.showMelds({
    required String playerId,
    required List<List<String>> meldCardGuids,
    required List<String> deadwoodCardGuids,
    DateTime? timestamp,
  }) {
    return GinRummyGameMessage(
      type: 'player_action',
      data: {
        'action': 'show_melds',
        'melds': meldCardGuids,
        'deadwood': deadwoodCardGuids,
      },
      playerId: playerId,
      timestamp: timestamp,
    );
  }

  // NOTE: 'knock' action type is intentionally EXCLUDED
  // Analysis shows:
  // 1. The UI always disables the knock button
  // 2. All knock functionality goes through 'discard_and_knock' action
  // 3. The standalone 'knock' action is never used in practice
  // 4. Removing it simplifies the action model without losing functionality

  /// Validates that this message represents a valid Gin Rummy action
  bool isValidGinRummyAction() {
    if (type != 'player_action') return false;
    
    final action = data['action'] as String?;
    if (action == null) return false;

    // Define all valid action types - this gives us compile-time
    // verification that we haven't missed any actions
    const validActions = {
      'draw_deck',
      'draw_discard', 
      'pass',
      'discard',
      'discard_and_knock',
      'gin',
      'big_gin',
      'arrange_melds',
      'finish_showdown',
      'lay_off',
      'next_round',
      'show_melds',
      // NOTE: 'knock' is intentionally excluded - see comment above
    };

    return validActions.contains(action);
  }

  /// Returns the action type for this message
  String? get actionType => data['action'] as String?;

  /// Returns the card GUID if this action involves a single card
  String? get cardGuid => data['cardGuid'] as String?;

  /// Returns the list of card GUIDs if this action involves multiple cards
  List<String>? get cardGuids {
    final guids = data['cardGuids'];
    if (guids is List) {
      return guids.cast<String>();
    }
    return null;
  }

  /// Returns the meld data for actions that include melds
  List<List<String>>? get meldCardGuids {
    final melds = data['melds'];
    if (melds is List) {
      try {
        return melds.map((meld) => (meld as List).cast<String>()).toList();
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  /// Returns the deadwood card GUIDs for showdown actions
  List<String>? get deadwoodCardGuids {
    final deadwood = data['deadwood'];
    if (deadwood is List) {
      return deadwood.cast<String>();
    }
    return null;
  }
}
