import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healtharcadia/screens/water/notifications/water_notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    loadStatus();
  }

  // LOAD STATUS DARI PREFS
  Future<void> loadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isActive = prefs.getBool("water_notif_active") ?? false;
    });
  }

  // SIMPAN STATUS KE PREFS
  Future<void> saveStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("water_notif_active", value);
  }

  // REQUEST NOTIFICATION PERMISSION
  Future<bool> requestPermission() async {
    final android = FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final granted = await android?.requestNotificationsPermission() ?? false;
    return granted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Pengingat Minum Air"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ============================
            // MASKOT
            // ============================
            SizedBox(
              height: 140,
              child: Image.asset("assets/images/bahagia.png"),
            ),
            const SizedBox(height: 10),

            const Text(
              "Ayo jaga hidrasi tubuhmu setiap hari!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Pengingat otomatis dikirim pada jam:\n"
              "06.00 · 09.00 · 12.00 · 14.00 · 16.00 · 18.00 · 20.00 · 22.00",
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.4),
            ),

            const SizedBox(height: 40),

            // ====================================
            // BUTTON: Aktifkan / Matikan Notifikasi
            // ====================================
            GestureDetector(
              onTap: () async {
                // 1. Jika ingin aktifkan → pastikan izin diberikan
                if (!isActive) {
                  final permitted = await requestPermission();

                  if (!permitted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Izin notifikasi ditolak ❌"),
                      ),
                    );
                    return;
                  }

                  // Jadwalkan
                  await WaterNotificationService.scheduleDailyWaterReminders();
                  await saveStatus(true);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pengingat aktif ✓")),
                  );
                } else {
                  // Matikan semua reminder
                  await WaterNotificationService.cancelAllWaterReminders();
                  await saveStatus(false);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pengingat dimatikan ❌")),
                  );
                }

                // Update UI
                setState(() {
                  isActive = !isActive;
                });
              },

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                    horizontal: 45, vertical: 18),
                decoration: BoxDecoration(
                  color: isActive ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: (isActive ? Colors.green : Colors.red)
                          .withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  isActive ? "Pengingat Aktif ✓" : "Aktifkan Pengingat",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
