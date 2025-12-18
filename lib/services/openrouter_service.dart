import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenRouterService {
  // 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
  final String apiKey = "";

  Future<String> sendMessage(String msg) async {
    final url = Uri.parse("https://openrouter.ai/api/v1/chat/completions");

    final headers = {
      "Authorization": "Bearer $apiKey",
      "HTTP-Referer": "https://yourapp.com",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "model": "deepseek/deepseek-r1",
      "messages": [
        {"role": "user", "content": msg}
      ]
    });

    final res = await http.post(url, headers: headers, body: body);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data["choices"][0]["message"]["content"];
    } else {
      return "Error: ${res.body}";
    }
  }
}
