/// Network debug configuration constants
/// 
/// Set [kNetworkDebugMode] to true to enable network debugging features
/// in both table and hand applications. This is a compile-time flag.

// Set this to true to enable network debugging features
const bool kNetworkDebugMode = true;

/// Maximum number of debug messages to keep in memory
const int kMaxDebugMessages = 100;

/// Debug message types
enum NetworkDebugMessageType {
  sent,
  received,
  error,
  info,
}

/// Network debug message data
class NetworkDebugMessage {
  final DateTime timestamp;
  final NetworkDebugMessageType type;
  final String messageType;
  final String source;
  final String? target;
  final String? details;

  NetworkDebugMessage({
    required this.timestamp,
    required this.type,
    required this.messageType,
    required this.source,
    this.target,
    this.details,
  });

  String get typeIcon {
    switch (type) {
      case NetworkDebugMessageType.sent:
        return '📤';
      case NetworkDebugMessageType.received:
        return '📥';
      case NetworkDebugMessageType.error:
        return '❌';
      case NetworkDebugMessageType.info:
        return 'ℹ️';
    }
  }

  String get formattedTime {
    return '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:'
        '${timestamp.second.toString().padLeft(2, '0')}.'
        '${(timestamp.millisecond ~/ 10).toString().padLeft(2, '0')}';
  }
}
