import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  // API KEY : AIzaSyCMvE9nuEIACwZkToq21VmSkKxfRzdiqUk
  final String apiKey = "";

  late final GenerativeModel model;

  GeminiService() {
    model = GenerativeModel(
      model: "gemini-1.5-flash",
      apiKey: apiKey,
    );
  }

  Future<String> sendMessage(String text) async {
    try {
      final response = await model.generateContent([
        Content.text(text),
      ]);

      return response.text ?? "Tidak ada jawaban.";
    } catch (e) {
      return "Error: $e";
    }
  }
}
