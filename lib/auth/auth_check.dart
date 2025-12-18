import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healtharcadia/main.dart';
import 'package:healtharcadia/auth/login_screen.dart';
import '../screens/home_screen.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // listening user login/logout
      builder: (context, snapshot) {
        
        // Masih check status → tampilkan loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.red),
            ),
          );
        }

        // Jika user sudah login → masuk ke MainNavigation (Home)
        if (snapshot.hasData) {
          return const MainNavigation();
        }

        // Jika belum login → masuk ke LoginScreen
        return const LoginScreen();
      },
    );
  }
}
