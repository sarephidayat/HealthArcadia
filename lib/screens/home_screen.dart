import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:healtharcadia/screens/artikel_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'game/game_screen.dart';
import 'artikel_screen.dart';
import 'chatbot_screen.dart';
import 'water/water_tracker_screen.dart';
import 'water/reminder/water_reminder_screen.dart';
import 'water/notifications/notification_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    BannerAd? bannerAd;
    bool isBannerLoaded = false;
    
    @override
    void initState() {
        super.initState();

        bannerAd = BannerAd(
            adUnitId: "ca-app-pub-3940256099942544/6300978111", // TEST ID Android
            size: AdSize.banner,
            request: const AdRequest(),
            listener: BannerAdListener(
            onAdLoaded: (Ad ad) {
                setState(() {
                isBannerLoaded = true;
                });
            },
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
                ad.dispose();
            },
            ),
        )..load();
    }
    @override
    void dispose() {
    bannerAd?.dispose();
    super.dispose();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ---------------- HEADER ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          "assets/images/bahagia.png",
                          width: 45,
                          height: 45,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selamat Datang Kembali",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "Syarifudin",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const NotificationScreen()),
                          );
                        },
                        child: const Icon(Icons.notifications_none, size: 28),
                      ),


                      const SizedBox(width: 10),

                      const Icon(Icons.person_outline, size: 28),
                    ],
                  ),

                ],
              ),

              const SizedBox(height: 20),

              // ---------------- BANNER CAROUSEL ----------------
              SizedBox(
                height: 160,
                child: PageView(
                  children: [
                    bannerCard(
                      "Edukasi Diabetes",
                      "Pelajari diabetes tipe 1 dengan aman",
                      "assets/images/doctor.png",
                    ),
                    bannerCard(
                      "Tips Kesehatan",
                      "Jaga pola hidup sehat setiap hari",
                      "assets/images/doctor.png",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // --------------- QUICK ACTIONS ----------------
              const Text(
                "Akses Cepat",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  quickButton(
                    FontAwesomeIcons.stethoscope,
                    "Chatbot",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ChatbotScreen()),
                      );
                    },
                  ),

                  quickButton(
                    FontAwesomeIcons.gamepad,
                    "Games",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const GameScreen()),
                      );
                    },
                  ),

                  quickButton(
                    FontAwesomeIcons.newspaper,
                    "Artikel",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ArtikelScreen()),
                      );
                    },
                  ),

                  quickButton(
                    FontAwesomeIcons.noteSticky,
                    "Minum Air",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const WaterTrackerScreen()),
                      );
                    },
                  ),
                ],
              ),


              const SizedBox(height: 20),

              // --------------- ARTIKEL TITLE + VIEW ALL ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Artikel Edukasi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ArtikelScreen()),
                      );
                    },
                    child: const Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

               // ⭐ ADMOB BANNER ADA DI SINI
              if (isBannerLoaded)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  child: SizedBox(
                    width: bannerAd!.size.width.toDouble(),
                    height: bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: bannerAd!),
                  ),
                ),

              // --------------- ARTIKEL LIST (SCROLLABLE ONLY) ----------------
              Expanded(
                child: ListView(
                  children: [
                    artikelListTile(
                      "Diabetes",
                      "Edukasi Diabetes Tipe 1: Mengenal cara mengelola dengan aman",
                      "assets/images/maskot.png",
                      "https://www.halodoc.com/artikel/mengenal-diabetes-tipe-1",
                    ),

                    artikelListTile(
                      "Kesehatan",
                      "Gejala & Penanganan Diabetes Tipe 1 yang Perlu Diketahui",
                      "assets/images/maskot.png",
                      "https://www.alodokter.com/diabetes-tipe-1",
                    ),

                    artikelListTile(
                      "Perbedaan",
                      "Perbedaan Diabetes Tipe 1 dan Tipe 2: Kenali Bedanya",
                      "assets/images/maskot.png",
                      "https://www.halodoc.com/artikel/perbedaan-diabetes-tipe-1-dan-tipe-2",
                    ),

                    artikelListTile(
                      "Gula Darah",
                      "Tips Menjaga Gula Darah Tetap Stabil",
                      "assets/images/maskot.png",
                      "https://promkes.kemkes.go.id/cara-mengontrol-gula-darah",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ----------- BANNER CARD -------------
  Widget bannerCard(String title, String subtitle, String imgPath) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      height: 160,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF4D4D), Color(0xFFFF8585)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: 0,
            child: Opacity(
              opacity: 0.85,
              child: Image.asset(
                imgPath,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.transparent
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 180,
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Ayo Sehat",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------- QUICK ACTION BUTTON -------------
  Widget quickButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: Colors.red, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }


  // ----------- ARTIKEL LIST TILE -------------
  Widget artikelListTile(String tag, String title, String image, String url) {
    return GestureDetector(
      onTap: () {
        launchUrlString(url, mode: LaunchMode.externalApplication);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TEXT LEFT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TAG
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // TITLE
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // IMAGE RIGHT
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: 90,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
