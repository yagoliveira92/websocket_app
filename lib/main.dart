import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:websocket_app/app/repository/chat_repository_impl.dart';

import 'app/repository/chat_repository.dart';
import 'app/view/chat_screen.dart';
import 'app/view_model/chat_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: MultiProvider(providers: [
        Provider<ChatRepository>(
          create: (_) => ChatRepositoryImpl(
            channel: IOWebSocketChannel.connect('ws://192.168.3.152:8080'),
          ),
          dispose: (_, repository) => repository.close(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatViewModel(
            Provider.of<ChatRepository>(
              context,
              listen: false,
            ),
          ),
        ),
      ], child: const ChatScreen(title: 'Chat App')),
    );
  }
}
