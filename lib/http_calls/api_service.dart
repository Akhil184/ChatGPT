import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
  static const String _apiUrl = "https://api.groq.com/openai/v1/chat/completions";
  static const String _apiKey = "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"; // Replace with your actual API key

  Future<String> fetchResponse(String message) async {
    final Map<String, dynamic> body = {
      "messages": [
        {"role": "user", "content": message}
      ],
      "model": "llama3-8b-8192",
      "temperature": 1,
      "max_tokens": 1024,
      "top_p": 1,
      "stream": false,
      "stop": null
    };

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["choices"]?[0]["message"]["content"] ?? "No response received";
      } else {
        return "Error: ${response.reasonPhrase}";
      }
    } catch (error) {
      return "Failed to connect to Groq API: $error";
    }
  }
}
