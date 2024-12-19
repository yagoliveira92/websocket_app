import 'package:websocket_app/app/model/message_model.dart';

abstract class ChatRepository {
  void sendMessage(Message message);
  Stream<Message> get messages;
  void close();
}
