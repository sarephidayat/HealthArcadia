import 'dart:convert';
import 'package:http/http.dart' as http;

class DeepSeekService {
  // API KEY : sk-0443df59c28a4e7e94e2cbb38170e9fb
  final String apiKey = ""; // API GRATIS

  Future<String> sendMessage(String message) async {
    final url = Uri.parse("https://api.deepseek.com/v1/chat/completions");

    final headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "model": "deepseek-chat",
      "messages": [
        {"role": "user", "content": message}
      ]
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["choices"][0]["message"]["content"];
    } else {
      return "Maaf, server sedang sibuk. Coba lagi.";
    }
  }
}
