import 'package:flutter/material.dart';
import 'package:healtharcadia/services/openrouter_service.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final OpenRouterService ai = OpenRouterService();

  List<Map<String, dynamic>> messages = [];

  // --------------------------
  // FUNCTION KIRIM PESAN USER
  // --------------------------
  void sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    String userMessage = _controller.text.trim();
    _controller.clear();

    setState(() {
      messages.add({"text": userMessage, "isUser": true});
    });

    await Future.delayed(const Duration(milliseconds: 100));
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

    String botReply = await ai.sendMessage(userMessage);

    setState(() {
      messages.add({"text": botReply, "isUser": false});
    });

    await Future.delayed(const Duration(milliseconds: 100));
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  // --------------------------
  // QUICK QUESTION KETIKA DITEKAN
  // --------------------------
  void sendQuickQuestion(String question) async {
    setState(() {
      messages.add({"text": question, "isUser": true});
    });

    String botReply = await ai.sendMessage(question);

    setState(() {
      messages.add({"text": botReply, "isUser": false});
    });

    await Future.delayed(const Duration(milliseconds: 100));
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  // --------------------------
  // QUICK CHIP WIDGET
  // --------------------------
  Widget quickChip(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: GestureDetector(
        onTap: () => sendQuickQuestion(text),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.redAccent),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------
  // BUILD UI
  // --------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            // HEADER ala WhatsApp
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                ),
                ],
            ),
            child: Row(
                children: [
                // Tombol Back (kalau Anda butuh)
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 24),
                ),

                const SizedBox(width: 12),

                // Foto profil / maskot
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                    "assets/images/bahagia.png",
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    ),
                ),

                const SizedBox(width: 12),

                // Nama + status
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                    Text(
                        "HealthArcadia Assistant",
                        style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        ),
                    ),
                    Text(
                        "Online",
                        style: TextStyle(
                        fontSize: 13,
                        color: Colors.green,
                        ),
                    ),
                    ],
                ),
                ],
            ),
            ),


            // QUICK QUESTIONS
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  quickChip("Apa itu diabetes tipe 1?"),
                  quickChip("Makanan aman untuk diabetes tipe 1"),
                  quickChip("Tanda gula darah rendah"),
                  quickChip("Cara mencegah hipoglikemia"),
                  quickChip("Olahraga aman diabetes tipe 1"),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // CHAT AREA
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool isUser = messages[index]["isUser"];
                  String text = messages[index]["text"];

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: 
                      isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      // Avatar bot
                      if (!isUser)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Image.asset(
                            "assets/images/bahagia.png",
                            width: 45,
                            height: 45,
                          ),
                        ),

                      // Bubble Chat
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.red : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            text,
                            style: TextStyle(
                              fontSize: 15,
                              color: isUser ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ),

                      // Avatar user
                      if (isUser)
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.person, size: 32),
                        ),
                    ],
                  );
                },
              ),
            ),

            // INPUT
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: "Ketik pertanyaan...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  GestureDetector(
                    onTap: sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
