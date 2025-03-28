import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat_bot/api/api_key.dart';

class ApiServiceChatGPT {
  Future<String> GetAPI(String message) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Authorization': 'Bearer $api_key',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
      "max_tokens": 100
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data['choices'][0]['message']['content'];
      return reply.trim();
    } else {
      final errorMessage = jsonDecode(response.body)['error'];
      throw Exception('API Error: $errorMessage');
    }
  }
}
