import 'package:flutter/material.dart';
import 'water_reminder_storage.dart';
import 'water_reminder_service.dart';

class WaterReminderScreen extends StatefulWidget {
  const WaterReminderScreen({super.key});

  @override
  State<WaterReminderScreen> createState() => _WaterReminderScreenState();
}

class _WaterReminderScreenState extends State<WaterReminderScreen> {
  bool enabled = false;
  int interval = 2; // default 2 jam

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    enabled = await WaterReminderStorage.loadEnabled();
    interval = await WaterReminderStorage.loadInterval();
    setState(() {});
  }

  void saveSettings() async {
    await WaterReminderStorage.saveEnabled(enabled);
    await WaterReminderStorage.saveInterval(interval);

    if (enabled) {
      await WaterReminderService.setReminder(interval);
    } else {
      await WaterReminderService.cancelReminder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengingat Minum Air"),
        foregroundColor: Colors.red,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Switch ON/OFF
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Aktifkan Pengingat",
                    style: TextStyle(fontSize: 18)),
                Switch(
                  value: enabled,
                  activeColor: Colors.red,
                  onChanged: (v) {
                    setState(() => enabled = v);
                    saveSettings();
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Pilih interval jam
            if (enabled)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ingatkan setiap:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Slider(
                    value: interval.toDouble(),
                    min: 1,
                    max: 6,
                    divisions: 5,
                    activeColor: Colors.red,
                    label: "$interval Jam",
                    onChanged: (v) {
                      setState(() => interval = v.toInt());
                    },
                    onChangeEnd: (v) => saveSettings(),
                  ),
                ],
              ),

            const SizedBox(height: 30),

            if (enabled)
              Text(
                "Notifikasi akan muncul setiap $interval jam 🚰",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
          ],
        ),
      ),
    );
  }
}
