import 'dart:async';
import 'package:flutter/foundation.dart';
import 'network_debug_constants.dart';

/// Service to manage network debugging messages and state
class NetworkDebugService extends ChangeNotifier {
  static final NetworkDebugService _instance = NetworkDebugService._internal();
  factory NetworkDebugService() => _instance;
  NetworkDebugService._internal();

  final List<NetworkDebugMessage> _messages = [];
  bool _isVisible = false;

  /// Get all debug messages
  List<NetworkDebugMessage> get messages => List.unmodifiable(_messages);

  /// Check if debug panel is visible
  bool get isVisible => _isVisible;

  /// Toggle debug panel visibility
  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  /// Show debug panel
  void showDebugPanel() {
    _isVisible = true;
    notifyListeners();
  }

  /// Hide debug panel
  void hideDebugPanel() {
    _isVisible = false;
    notifyListeners();
  }

  /// Add a debug message
  void addMessage(NetworkDebugMessage message) {
    if (!kNetworkDebugMode) return;

    _messages.add(message);
    
    // Keep only the last kMaxDebugMessages
    if (_messages.length > kMaxDebugMessages) {
      _messages.removeAt(0);
    }
    
    notifyListeners();
  }

  /// Log a sent message
  void logSent({
    required String messageType,
    required String source,
    String? target,
    String? details,
  }) {
    addMessage(NetworkDebugMessage(
      timestamp: DateTime.now(),
      type: NetworkDebugMessageType.sent,
      messageType: messageType,
      source: source,
      target: target,
      details: details,
    ));
  }

  /// Log a received message
  void logReceived({
    required String messageType,
    required String source,
    String? target,
    String? details,
  }) {
    addMessage(NetworkDebugMessage(
      timestamp: DateTime.now(),
      type: NetworkDebugMessageType.received,
      messageType: messageType,
      source: source,
      target: target,
      details: details,
    ));
  }

  /// Log an error
  void logError({
    required String messageType,
    required String source,
    String? details,
  }) {
    addMessage(NetworkDebugMessage(
      timestamp: DateTime.now(),
      type: NetworkDebugMessageType.error,
      messageType: messageType,
      source: source,
      details: details,
    ));
  }

  /// Log info
  void logInfo({
    required String messageType,
    required String source,
    String? details,
  }) {
    addMessage(NetworkDebugMessage(
      timestamp: DateTime.now(),
      type: NetworkDebugMessageType.info,
      messageType: messageType,
      source: source,
      details: details,
    ));
  }

  /// Clear all debug messages
  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }

  /// Get messages filtered by type
  List<NetworkDebugMessage> getMessagesByType(NetworkDebugMessageType type) {
    return _messages.where((msg) => msg.type == type).toList();
  }

  /// Get recent messages (last N messages)
  List<NetworkDebugMessage> getRecentMessages([int count = 10]) {
    final startIndex = _messages.length > count ? _messages.length - count : 0;
    return _messages.sublist(startIndex);
  }
}
