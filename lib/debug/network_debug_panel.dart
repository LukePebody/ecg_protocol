import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'network_debug_service.dart';
import 'network_debug_constants.dart';

/// Debug panel widget that shows network message logs
class NetworkDebugPanel extends StatelessWidget {
  const NetworkDebugPanel({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kNetworkDebugMode) {
      return const SizedBox.shrink();
    }

    return Consumer<NetworkDebugService>(
      builder: (context, debugService, child) {
        if (!debugService.isVisible) {
          return const SizedBox.shrink();
        }

        return Positioned(
          top: 60,
          right: 20,
          width: 400,
          height: 500,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[600]!),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.network_check, color: Colors.white, size: 16),
                        const SizedBox(width: 8),
                        const Text(
                          'Network Debug Log',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white, size: 16),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: debugService.clearMessages,
                          tooltip: 'Clear log',
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 16),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: debugService.hideDebugPanel,
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                  ),
                  // Message list
                  Expanded(
                    child: ListView.builder(
                      reverse: true, // Show newest messages at top
                      padding: const EdgeInsets.all(4),
                      itemCount: debugService.messages.length,
                      itemBuilder: (context, index) {
                        final message = debugService.messages[debugService.messages.length - 1 - index];
                        return _buildMessageTile(message);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageTile(NetworkDebugMessage message) {
    Color getTypeColor() {
      switch (message.type) {
        case NetworkDebugMessageType.sent:
          return Colors.blue[300]!;
        case NetworkDebugMessageType.received:
          return Colors.green[300]!;
        case NetworkDebugMessageType.error:
          return Colors.red[300]!;
        case NetworkDebugMessageType.info:
          return Colors.grey[300]!;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                message.typeIcon,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 4),
              Text(
                message.formattedTime,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: getTypeColor(),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  message.messageType,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                'From: ${message.source}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              if (message.target != null) ...[
                const SizedBox(width: 8),
                Text(
                  'To: ${message.target}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ],
          ),
          if (message.details != null) ...[
            const SizedBox(height: 2),
            Text(
              message.details!,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 9,
                fontFamily: 'monospace',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}

/// Floating debug button that shows/hides the debug panel
class NetworkDebugButton extends StatelessWidget {
  const NetworkDebugButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kNetworkDebugMode) {
      return const SizedBox.shrink();
    }

    return Consumer<NetworkDebugService>(
      builder: (context, debugService, child) {
        return Positioned(
          top: 20,
          right: 20,
          child: FloatingActionButton.small(
            heroTag: 'network_debug',
            backgroundColor: debugService.isVisible ? Colors.red[700] : Colors.blue[700],
            child: Icon(
              debugService.isVisible ? Icons.close : Icons.bug_report,
              color: Colors.white,
              size: 20,
            ),
            onPressed: debugService.toggleVisibility,
          ),
        );
      },
    );
  }
}
