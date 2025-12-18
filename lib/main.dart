import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart'; // WAJIB ADA
import 'screens/home_screen.dart';
import 'screens/game/game_screen.dart';
import 'screens/chatbot_screen.dart';
import 'screens/artikel_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/water/notifications/water_notification_service.dart';
import 'splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ⭐ INIT FIREBASE
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ⭐ INIT Notifikasi Minum Air
  await WaterNotificationService.init();

  // ⭐ Request izin notifikasi (Android 13+)
  final android = FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  await android?.requestNotificationsPermission();

  // ⭐ INIT AdMob
  MobileAds.instance.initialize();

  runApp(const HealthArcadia());
}

class HealthArcadia extends StatelessWidget {
  const HealthArcadia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      // Pertama kali aplikasi dibuka → Splash
      home: const SplashScreen(),
    );
  }
}

// ===============================================
// BOTTOM NAVIGATION
// ===============================================

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const GameScreen(),
    const ChatbotScreen(),
    const ArtikelScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const FaIcon(
          FontAwesomeIcons.stethoscope,
          color: Colors.white,
          size: 28,
        ),
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem(Icons.home, "Home", 0),
              navItem(FontAwesomeIcons.gamepad, "Games", 1),
              const SizedBox(width: 30),
              navItem(FontAwesomeIcons.newspaper, "Artikel", 3),
              navItem(Icons.person, "Profile", 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.red : Colors.grey,
            size: 28,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.red : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
