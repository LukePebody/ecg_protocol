/// Network events that can occur during hosting and discovery operations
abstract class NetworkEvent {
  const NetworkEvent();

  factory NetworkEvent.hostingStarted(String code) = HostingStartedEvent;
  factory NetworkEvent.hostingStopped() = HostingStoppedEvent;
  factory NetworkEvent.clientConnected(int count) = ClientConnectedEvent;
  factory NetworkEvent.clientDisconnected(int count) = ClientDisconnectedEvent;
  factory NetworkEvent.messageReceived(Map<String, dynamic> message) = MessageReceivedEvent;
  factory NetworkEvent.discoveryStarted() = DiscoveryStartedEvent;
  factory NetworkEvent.discoveryCompleted(List<dynamic> hosts) = DiscoveryCompletedEvent;
  factory NetworkEvent.hostDiscovered(dynamic host) = HostDiscoveredEvent;
}

/// Hosting events
class HostingStartedEvent extends NetworkEvent {
  final String code;
  const HostingStartedEvent(this.code);
}

class HostingStoppedEvent extends NetworkEvent {
  const HostingStoppedEvent();
}

/// Client connection events
class ClientConnectedEvent extends NetworkEvent {
  final int clientCount;
  const ClientConnectedEvent(this.clientCount);
}

class ClientDisconnectedEvent extends NetworkEvent {
  final int clientCount;
  const ClientDisconnectedEvent(this.clientCount);
}

/// Message events
class MessageReceivedEvent extends NetworkEvent {
  final Map<String, dynamic> message;
  const MessageReceivedEvent(this.message);
}

/// Discovery events
class DiscoveryStartedEvent extends NetworkEvent {
  const DiscoveryStartedEvent();
}

class DiscoveryCompletedEvent extends NetworkEvent {
  final List<dynamic> hosts; // List of GameHost objects
  const DiscoveryCompletedEvent(this.hosts);
}

class HostDiscoveredEvent extends NetworkEvent {
  final dynamic host; // GameHost object
  const HostDiscoveredEvent(this.host);
}
