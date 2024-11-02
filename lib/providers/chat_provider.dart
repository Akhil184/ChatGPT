import 'package:flutter/material.dart';
import '../http_calls/api_service.dart';


class ChatProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Map<String, String>> _messages = [];
  List<Map<String, String>> get messages => _messages;

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;

    // Add user message
    _messages.add({"sender": "user", "text": message});
    _messages.add({"sender": "assistant", "text": "Loading..."}); // Temporary loading message
    notifyListeners();

    // Fetch response from API
    String response = await _apiService.fetchResponse(message);

    // Update assistant's response
    _messages.removeLast(); // Remove loading message
    _messages.add({"sender": "assistant", "text": response});
    notifyListeners();
  }
}
