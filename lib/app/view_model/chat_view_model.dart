import 'package:flutter/material.dart';
import 'package:websocket_app/app/model/message_model.dart';
import 'package:websocket_app/app/repository/chat_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatRepository _repository;
  final List<Message> _messages = [];

  ChatViewModel(this._repository) {
    _repository.messages.listen((message) {
      _messages.add(message);
      notifyListeners();
    });
  }

  List<Message> get messages => _messages;

  void sendMessage(String text, String sender) {
    final message =
        Message(sender: sender, text: text, timestamp: DateTime.now());
    _repository.sendMessage(message);
  }

  @override
  void dispose() {
    _repository.close();
    super.dispose();
  }
}
