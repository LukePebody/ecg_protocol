class ProtocolConstants {
  static const String messageTypeCardData = 'card_data';
  static const String messageTypeGameState = 'game_state';
  static const String messageTypePlayerAction = 'player_action';
  static const String messageTypeHeartbeat = 'heartbeat';

  static const int defaultPort = 8080;
  static const Duration heartbeatInterval = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 10);
}
