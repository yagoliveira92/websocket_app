import 'package:websocket_app/app/view_model/chat_view_model.dart';

abstract class ChatCommand {
  Future<void> execute(ChatViewModel viewModel);
}

class SendMessageCommand implements ChatCommand {
  final String text;
  final String sender;

  SendMessageCommand({required this.text, required this.sender});

  @override
  Future<void> execute(ChatViewModel viewModel) async {
    if (text.isEmpty) {
      print("Mensagem vazia!");
      return;
    }
    viewModel.sendMessage(text, sender);
  }
}
