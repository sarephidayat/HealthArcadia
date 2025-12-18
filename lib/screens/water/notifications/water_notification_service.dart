import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class WaterNotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// ===============================
  /// INIT — WAJIB DIPANGGIL DI main()
  /// ===============================
  static Future<void> init() async {
    // Init timezone (WAJIB)
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidInit,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // TODO: Kalau nanti mau buka halaman tertentu saat notif di-tap, atur di sini.
      },
    );
  }

  /// =====================================
  /// HELPER — Mencari waktu jadwal berikutnya
  /// =====================================
  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Jika sudah lewat, jadwalkan untuk esok hari
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  /// ==================================================
  /// JADWALKAN REMINDER MINUM AIR SETIAP HARI
  /// ==================================================
  static Future<void> scheduleDailyWaterReminders() async {
    // NOTE:
    // 4:51 hanya untuk testing. Nanti kalau sudah yakin jalan,
    // ganti jadi 6, 9, 12, 14, 16, 18, 20, 22.
    final List<Map<String, int>> times = [
      {"id": 100, "hour": 4,  "minute": 51}, // TEST
      {"id": 101, "hour": 9,  "minute": 0},
      {"id": 102, "hour": 12, "minute": 0},
      {"id": 103, "hour": 14, "minute": 0},
      {"id": 104, "hour": 16, "minute": 0},
      {"id": 105, "hour": 18, "minute": 0},
      {"id": 106, "hour": 20, "minute": 0},
      {"id": 107, "hour": 22, "minute": 0},
    ];

    const androidDetails = AndroidNotificationDetails(
      'water_channel',
      'Pengingat Minum Air',
      channelDescription: 'Notifikasi rutin untuk minum air putih',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    final details = NotificationDetails(android: androidDetails);

    for (final t in times) {
      final int id = t["id"]!;
      final int hour = t["hour"]!;
      final int minute = t["minute"]!;

      final schedule = _nextInstanceOfTime(hour, minute);

      // Log buat debug di console
      // (muncul di Debug Console saat running)
      // ignore: avoid_print
      print("⏰ Scheduling reminder $id at $schedule");

      await _plugin.zonedSchedule(
        id,
        'Saatnya Minum Air 💧',
        'Jangan lupa minum agar tubuh tetap sehat!',
        schedule,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time, // ulang harian
        payload: 'water_reminder',
      );
    }
  }

  /// =============================
  /// CANCEL SEMUA PENGINGAT
  /// =============================
  static Future<void> cancelAllWaterReminders() async {
    await _plugin.cancelAll();
  }
}
