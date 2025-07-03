/// Network discovery configuration constants
class DiscoveryConstants {
  // mDNS Service Discovery
  static const String mdnsServiceType = '_ecg-table._tcp';
  static const String mdnsServiceName = 'ECG Table Game';

  // Discovery timeouts
  static const Duration discoveryTimeout = Duration(seconds: 10);
  static const Duration hostCheckTimeout = Duration(seconds: 2);
  static const Duration bluetoothTimeout = Duration(seconds: 3);

  // Network scanning
  static const List<int> commonPorts = [8080, 3000, 8000, 8888, 9000];
  static const int maxNetworkHosts = 254;

  // Service identification
  static const String serviceIdentifier = 'ecg-table';
  static const String protocolVersion = '1.0.0';

  // Endpoints
  static const String infoEndpoint = '/info';
  static const String joinEndpoint = '/join';
  static const String connectEndpoint = '/connect';
  static const String assetsEndpoint = '/assets/';
}

/// Connection method types for host discovery
enum ConnectionMethod {
  wifi,
  bluetooth,
  manual;

  String get displayName {
    switch (this) {
      case ConnectionMethod.wifi:
        return 'WiFi';
      case ConnectionMethod.bluetooth:
        return 'Bluetooth';
      case ConnectionMethod.manual:
        return 'Manual';
    }
  }
}

/// Represents a discovered game host
class GameHost {
  final String name;
  final String address;
  final int port;
  final ConnectionMethod method;
  final String gameCode;
  final int playerCount;
  final String? deviceId; // For Bluetooth connections
  final List<String>? capabilities; // Supported game types
  final String? version; // Protocol version

  const GameHost({
    required this.name,
    required this.address,
    required this.port,
    required this.method,
    required this.gameCode,
    this.playerCount = 0,
    this.deviceId,
    this.capabilities,
    this.version,
  });

  String get displayName => '$name ($gameCode)';

  String get connectionString {
    switch (method) {
      case ConnectionMethod.wifi:
        return '$address:$port';
      case ConnectionMethod.bluetooth:
        return deviceId ?? address;
      case ConnectionMethod.manual:
        return '$address:$port';
    }
  }

  /// Create from service discovery info
  factory GameHost.fromServiceInfo(Map<String, dynamic> info) {
    return GameHost(
      name: info['name'] ?? 'ECG Table',
      address: info['address'] ?? 'localhost',
      port: info['port'] ?? DiscoveryConstants.commonPorts.first,
      method: ConnectionMethod.wifi,
      gameCode: info['code'] ?? '',
      playerCount: info['players'] ?? 0,
      capabilities: info['capabilities']?.cast<String>(),
      version: info['version'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'port': port,
        'method': method.name,
        'gameCode': gameCode,
        'playerCount': playerCount,
        if (deviceId != null) 'deviceId': deviceId,
        if (capabilities != null) 'capabilities': capabilities,
        if (version != null) 'version': version,
      };
}
