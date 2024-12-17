/*import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket _socket;

  // Getter para acceder al socket desde fuera de la clase
  IO.Socket get socket => _socket;

  void connect() {
    _socket = IO.io('http://localhost:5000', IO.OptionBuilder()
        .setTransports(['websocket']) // Transmisión mediante WebSocket
        .build());

    _socket.onConnect((_) {
      print('Conectado al servidor WebSocket');
    });

    _socket.onDisconnect((_) {
      print('Desconectado del servidor');
    });
  }

  void sendMessage(String message) {
    _socket.emit('chatMessage', message);
  }

  void disconnect() {
    _socket.disconnect();
  }
}

*/

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket _socket;

  // Getter para acceder al socket desde fuera de la clase
  IO.Socket get socket => _socket;

  // Método para conectar al servidor WebSocket y con token JWT
  void connect(String token) {
    _socket = IO.io(
      'http://10.0.0.2.2:5000', // URL del servidor Socket.IO
      IO.OptionBuilder()
          .setTransports(['websocket']) // Transmisión mediante WebSocket
          .setAuth({'token': token}) //Enviar el token JWT en el 3handshake
          .disableAutoConnect() // Deshabilita conexión automática
          .build(),
    );

    _socket.connect();

    // Eventos de conexión
    _socket.onConnect((_) {
      print('Conectado al servidor WebSocket');
    });

    _socket.onDisconnect((_) {
      print('Desconectado del servidor');
    });

    // Manejar errores
    _socket.onConnectError((data) {
      print('Error de conexión: $data');
    });

    _socket.onError((data) {
      print('Error en el socket: $data');
    });
  }

  // Método para enviar un mensaje al servidor
  void sendMessage(String message) {
    _socket.emit('chatMessage', message);
  }

  // Método para desconectar el socket
  void disconnect() {
    _socket.disconnect();
    print('Conexión cerrada');
  }
}
