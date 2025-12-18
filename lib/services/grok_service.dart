import 'dart:convert';
import 'package:http/http.dart' as http;

class GrokService {
  // API KEY : xai-t1UuaDGBaD1Obms7w3YthV1ksqayInOVh5azZnyTQbkQNxLA6Zhsb0G95Z0tsprMMUTs7sXAzaFUkIQX
  final String apiKey = ""; // GANTI API KEY ANDA

  Future<String> sendMessage(String message) async {
    final url = Uri.parse("https://api.x.ai/v1/chat/completions");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    final body = jsonEncode({
      "model": "grok-4-latest",   // MODEL TERBARU & GRATIS
      "messages": [
        {"role": "user", "content": message}
      ]
    });

    try {
      final res = await http.post(url, headers: headers, body: body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data["choices"][0]["message"]["content"];
      } else {
        return "Error Grok: ${res.body}";
      }
    } catch (e) {
      return "Terjadi kesalahan: $e";
    }
  }
}
