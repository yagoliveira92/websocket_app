import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websocket_app/app/view_model/chat_view_model.dart';

class ChatScreen extends StatefulWidget {
  final String title;
  const ChatScreen({super.key, required this.title});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final _nomeUsuario = "Cliente";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<ChatViewModel>(
                builder: (context, viewModel, child) {
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: viewModel.messages.length,
                          (context, index) {
                            final message = viewModel.messages[index];
                            return ListTile(
                              title: Text.rich(
                                TextSpan(
                                  text: message.sender,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ': ${message.text}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Form(
              child: TextFormField(
                controller: _controller,
                decoration:
                    const InputDecoration(labelText: 'Escrever mensagem...'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<ChatViewModel>(context, listen: false)
                        .sendMessage(_controller.text, _nomeUsuario);
                    _controller.clear();
                  },
                  child: const Text('Enviar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
