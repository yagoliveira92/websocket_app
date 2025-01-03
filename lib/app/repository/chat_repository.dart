import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_app/app/model/message_model.dart';

class ChatRepository {
  late final WebSocketChannel channel;
  final StreamController<Message> _messageController =
      StreamController<Message>.broadcast();

  ChatRepository({required this.channel}) {}

  Stream<Message> get messages => _messageController.stream;

  void sendMessage(Message message) {}

  void close() {}
}
