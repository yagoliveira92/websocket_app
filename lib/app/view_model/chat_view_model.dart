import 'package:flutter/material.dart';
import 'package:websocket_app/app/model/message_model.dart';
import 'package:websocket_app/app/repository/chat_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatRepository _repository;
  final List<Message> _messages = [];

  ChatViewModel(this._repository) {}

  List<Message> get messages => _messages;

  void sendMessage(String text, String sender) {}

  @override
  void dispose() {}
}
