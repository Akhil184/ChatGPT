// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/input_field.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('ChatGPT'),centerTitle: true,),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messages[index];
                return ChatBubble(
                  text: message["text"] ?? "",
                  isUser: message["sender"] == "user",
                );
              },
            ),
          ),
          InputField(
            onSend: (message) {
              chatProvider.sendMessage(message);
            },
          ),
        ],
      ),
    );
  }
}
