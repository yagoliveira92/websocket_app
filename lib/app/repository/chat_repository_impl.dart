import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_app/app/model/message_model.dart';

import 'chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  late final WebSocketChannel channel;
  final StreamController<Message> _messageController =
      StreamController<Message>.broadcast();

  ChatRepositoryImpl({required this.channel}) {
    channel.stream.listen((message) {
      try {
        final decodedMessage = jsonDecode(message);
        _messageController.add(Message.fromJson(decodedMessage));
      } catch (e) {
        print('Erro ao decodificar mensagem: $e');
      }
    });
  }

  @override
  Stream<Message> get messages => _messageController.stream;

  @override
  void sendMessage(Message message) {
    channel.sink
        .add(jsonEncode(message.toJson())); // Envia a mensagem como JSON
  }

  @override
  void close() {
    channel.sink.close();
    _messageController.close();
  }
}
