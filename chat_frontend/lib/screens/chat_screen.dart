import 'package:flutter/material.dart';
import '../services/socket_service.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final String token; // Token JWT DESPUES DEL LOGIN

  const ChatScreen({Key? key, required this.username, required this.token})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _socketService = SocketService();
  final _messageController = TextEditingController();
  final List<String> _messages = []; // Lista para almacenar los mensajes

  @override
  void initState() {
    super.initState();

    // Conexión al servidor Socket.IO
    _socketService.connect(widget.token);

    // Escuchar mensajes del servidor
    _socketService.socket.on('message', (data) {
      setState(() {
        _messages.add(data); // Agregar el mensaje recibido a la lista
      });
    });
  }

  // Función para enviar un mensaje
  void _sendMessage() {
    final message = '${widget.username}: ${_messageController.text}';
    if (_messageController.text.isNotEmpty) {
      _socketService.sendMessage(message); // Enviar el mensaje al servidor
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _socketService.disconnect(); // Cerrar la conexión al salir
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Chat - ${widget.username}'), // Mostrar el nombre del usuario
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Escribe un mensaje'),
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
