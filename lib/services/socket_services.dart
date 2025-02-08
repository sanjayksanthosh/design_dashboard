// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService {
//   late IO.Socket socket;
//   final String serverUrl;

//   SocketService({required this.serverUrl}) {
//     _initSocket();
//   }

//   void _initSocket() {
//     socket = IO.io(
//       serverUrl,
//       IO.OptionBuilder()
//           .setTransports(['websocket']) // Start with WebSocket only
//           .enableReconnection() // Enable reconnection
//           .setReconnectionAttempts(5) // Maximum number of reconnection attempts
//           .setReconnectionDelay(10000) // Delay between reconnection attempts (10 seconds)
//           .setPath('/socket.io/') // Must match server path
//           .build(),
//     );

//     // Connection event handlers
//     socket.onConnect((_) {
//       print('Connected to Socket.IO server! Socket ID: ${socket.id}');
//     });

//     socket.onConnectError((error) {
//       print('Connection error: $error');
//     });

//     socket.onDisconnect((reason) {
//       print('Disconnected from Socket.IO server. Reason: $reason');
//     });

//     socket.onError((error) {
//       print('Socket error: $error');
//     });

//     // Connect to the server
//     socket.connect();
//   }

//   void dispose() {
//     socket.dispose();
//   }

//   // Example method to emit events
//   void sendMessage(String event, dynamic data) {
//     if (socket.connected) {
//       socket.emit(event, data);
//     } else {
//       print('Socket is not connected. Message not sent.');
//     }
//   }
// }
