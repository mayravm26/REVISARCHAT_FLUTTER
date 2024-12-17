import 'package:chat_frontend/screens/chat_screen.dart';
import 'package:chat_frontend/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'screens/chat_screen.dart'; // Importa tu ChatScreen
import 'screens/login_screen.dart'; //Importa login
//import 'screens/register_screen.dart'; // Import register

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/register',
      routes: {
        '/register': (context) => RegisterScreen(), // Pantalla de Registro
        '/login': (context) => LoginScreen(), // Pantalla de Login
        '/chat': (context) => ChatScreen(
              username: ModalRoute.of(context)!.settings.arguments as String,
              token: '',
            ), // Pantalla de Chat
      },
    );
  }
}
