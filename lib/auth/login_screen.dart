import 'package:flutter/material.dart';
import 'package:healtharcadia/auth/auth_service.dart';
import '../main.dart';
import '../screens/home_screen.dart';
import 'auth_check.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  // ========================
  // UI LOGIN
  // ========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 20),

                // ============================
                // MASKOT LOGIN
                // ============================
                SizedBox(
                  height: 200,
                  child: Image.asset("assets/images/bahagia.png"),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Selamat Datang!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Masuk untuk melanjutkan perjalanan sehatmu",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // ============================
                // EMAIL FIELD
                // ============================
                TextField(
                  controller: emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ============================
                // PASSWORD FIELD
                // ============================
                TextField(
                  controller: passC,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ============================
                // BUTTON LOGIN MANUAL
                // ============================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // NOTE: logic login manual belum dibuat
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const AuthCheck()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Masuk",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ============================
                // PEMISAH
                // ============================
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("atau masuk dengan"),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),

                const SizedBox(height: 25),

                // ============================
                // LOGIN GOOGLE BUTTON
                // ============================
                ElevatedButton.icon(
                  icon: Image.asset("assets/images/google.png", height: 26),
                  label: const Text(
                    "Login dengan Google",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  onPressed: () async {
                    final user = await AuthService.signInWithGoogle();

                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AuthCheck(),
                        ),
                      );
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    elevation: 3,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Kami tidak akan pernah memposting apapun.\nAkun Google-mu aman sepenuhnya.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
