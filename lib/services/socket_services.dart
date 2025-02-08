import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  SocketService() {
    _initSocket();
  }

  void _initSocket() {
    // Replace with your actual IP or domain and correct port
    socket = IO.io(
      'https://etra-citizen.onrender.com', // Example for Android emulator
      <String, dynamic>{
        // Let the client decide on the best transport, with fallback
        'transports': <String>['websocket', 'polling'],
        // Configure reconnection attempts
        'reconnection': true,
        'autoConnect': false, 
      },
    );

    // Register event listeners
    socket.on('connect', (_) {
      print('Socket connected with id: ${socket.id}');
    });
socket.on('connect_error', (error) {
  print('Socket connection error: ${error.toString()}');
});

socket.on('error', (error) {
  print('Socket error: ${error.toString()}');
});
    socket.on('disconnect', (_) {
      print('Socket disconnected');
    });

    // You may see an event object or error object here
    socket.on('connect_error', (error) {
      print('Socket connection error: $error');
    });

    socket.on('error', (error) {
      print('Socket error: $error');
    });

    // Manually connect
    socket.connect();
  }

  void dispose() {
    socket.disconnect();
    socket.destroy();
  }
}
