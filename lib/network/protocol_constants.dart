class ProtocolConstants {
  static const String messageTypeCardData = 'card_data';
  static const String messageTypeGameState = 'game_state';
  static const String messageTypePlayerAction = 'player_action';
  static const String messageTypeHeartbeat = 'heartbeat';

  // Enhanced protocol message types
  static const String messageTypeServiceInfo = 'service_info';
  static const String messageTypeDiscoveryRequest = 'discovery_request';
  static const String messageTypeHostAnnouncement = 'host_announcement';

  static const int defaultPort = 8080;
  static const Duration heartbeatInterval = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 10);

  // Enhanced network timeouts
  static const Duration discoveryTimeout = Duration(seconds: 5);
  static const Duration hostVerificationTimeout = Duration(seconds: 2);
}
