import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ArtikelScreen extends StatefulWidget {
  const ArtikelScreen({super.key});

  @override
  State<ArtikelScreen> createState() => _ArtikelScreenState();
}

class _ArtikelScreenState extends State<ArtikelScreen> {
  TextEditingController searchController = TextEditingController();

  BannerAd? bannerAd;
  bool isBannerLoaded = false;

  @override
  void initState() {
    super.initState();

    // 🔥 LOAD ADMOB
    bannerAd = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111", // TEST ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() => isBannerLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();

    filteredArticles = allArticles;
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  // =======================================
  //  🔥 FULL DAFTAR ARTIKEL (20+ ARTIKEL)
  // =======================================
  List<Map<String, String>> allArticles = [
    {
      "tag": "Diabetes",
      "title": "Edukasi Diabetes Tipe 1: Mengenal cara mengelola dengan aman",
      "img": "assets/images/maskot.png",
      "url": "https://www.halodoc.com/artikel/mengenal-diabetes-tipe-1",
    },
    {
      "tag": "Kesehatan",
      "title": "Gejala & Penanganan Diabetes Tipe 1 yang Perlu Diketahui",
      "img": "assets/images/maskot.png",
      "url": "https://www.alodokter.com/diabetes-tipe-1",
    },
    {
      "tag": "Perbedaan",
      "title": "Perbedaan Diabetes Tipe 1 dan Tipe 2: Kenali Bedanya",
      "img": "assets/images/maskot.png",
      "url": "https://www.halodoc.com/artikel/perbedaan-diabetes-tipe-1-dan-tipe-2",
    },
    {
      "tag": "Gula Darah",
      "title": "Tips Menjaga Gula Darah Tetap Stabil",
      "img": "assets/images/maskot.png",
      "url": "https://promkes.kemkes.go.id/cara-mengontrol-gula-darah",
    },
    {
      "tag": "Gizi",
      "title": "Pola Makan Sehat untuk Penderita Diabetes Tipe 1",
      "img": "assets/images/maskot.png",
      "url": "https://www.alodokter.com/panduan-diet-untuk-penderita-diabetes",
    },
    {
      "tag": "Autoimun",
      "title": "Penyebab Diabetes Tipe 1 dan Faktor Risiko Penting",
      "img": "assets/images/maskot.png",
      "url": "https://www.mayoclinic.org/diseases-conditions/type-1-diabetes",
    },
    {
      "tag": "Olahraga",
      "title": "Olahraga Aman untuk Penderita Diabetes Tipe 1",
      "img": "assets/images/maskot.png",
      "url": "https://diabetes.org/healthy-living/fitness",
    },
    {
      "tag": "Hipoglikemia",
      "title": "Gejala, Faktor Penyebab, dan Cara Mencegah Hipoglikemia",
      "img": "assets/images/maskot.png",
      "url": "https://www.halodoc.com/artikel/kenali-hipoglikemia-gejala-dan-penanganannya",
    },
    {
      "tag": "Hiperglikemia",
      "title": "Penyebab Gula Darah Tinggi dan Cara Mengendalikannya",
      "img": "assets/images/maskot.png",
      "url": "https://www.alodokter.com/hiperglikemia",
    },
    {
      "tag": "Edukasi",
      "title": "Hidup Sehat dengan Diabetes: Panduan Pemula",
      "img": "assets/images/maskot.png",
      "url": "https://www.nhs.uk/conditions/type-1-diabetes",
    },
    {
      "tag": "Insulin",
      "title": "Cara Kerja Insulin dalam Tubuh Penderita Diabetes Tipe 1",
      "img": "assets/images/maskot.png",
      "url": "https://www.cdc.gov/diabetes/basics/diabetes.html",
    },
    {
      "tag": "Pencegahan",
      "title": "Bagaimana Mencegah Komplikasi Diabetes Tipe 1?",
      "img": "assets/images/maskot.png",
      "url": "https://www.healthdirect.gov.au/type-1-diabetes",
    },
    {
      "tag": "Psikologi",
      "title": "Manajemen Stress untuk Penderita Diabetes Tipe 1",
      "img": "assets/images/maskot.png",
      "url": "https://www.endocrineweb.com/conditions/type-1-diabetes",
    },
    {
      "tag": "Anak",
      "title": "Panduan Diabetes Tipe 1 pada Anak dan Remaja",
      "img": "assets/images/maskot.png",
      "url": "https://kidshealth.org/en/parents/type1.html",
    },
    {
      "tag": "Komplikasi",
      "title": "Komplikasi Diabetes dan Cara Menghindarinya",
      "img": "assets/images/maskot.png",
      "url": "https://www.hopkinsmedicine.org/health/conditions-and-diseases/diabetes",
    },
    {
      "tag": "Pemeriksaan",
      "title": "Cara Membaca Hasil Pemeriksaan Gula Darah",
      "img": "assets/images/maskot.png",
      "url": "https://www.webmd.com/diabetes/guide/normal-blood-sugar-levels-chart",
    },
    {
      "tag": "Lifestyle",
      "title": "Tips Menjalani Hidup Sehat dengan Diabetes Tipe 1",
      "img": "assets/images/maskot.png",
      "url": "https://www.medicalnewstoday.com/articles/323627",
    },
    {
      "tag": "Teknologi",
      "title": "Pemantauan Gula Darah dengan Glukometer & CGM",
      "img": "assets/images/maskot.png",
      "url": "https://www.diabetes.org.uk/guide-to-diabetes/managing-your-diabetes/testing",
    },
    {
      "tag": "Darurat",
      "title": "Ketoasidosis Diabetik (DKA) dan Cara Mengatasinya",
      "img": "assets/images/maskot.png",
      "url": "https://my.clevelandclinic.org/health/diseases/21989-dka-diabetic-ketoacidosis",
    },
  ];

  List<Map<String, String>> filteredArticles = [];

  // 🔎 Search filter
  void runFilter(String keyword) {
    setState(() {
      filteredArticles = keyword.isEmpty
          ? allArticles
          : allArticles.where((article) {
              return article["title"]!.toLowerCase().contains(keyword.toLowerCase()) ||
                  article["tag"]!.toLowerCase().contains(keyword.toLowerCase());
            }).toList();
    });
  }

  // =================================================
  //                BUILD UI
  // =================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // supaya bisa custom tombol back
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 🔙 Button Back
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.red,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            // 🟥 Title Merah dan Center relatif
            const Expanded(
              child: Text(
                "Artikel Edukasi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 34), 
            // untuk mengimbangi icon back agar judul benar-benar center
          ],
        ),
      ),


      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: searchController,
                onChanged: runFilter,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Cari artikel...",
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
          ),

          // ⭐ ADMOB BANNER
          if (isBannerLoaded)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: bannerAd!.size.width.toDouble(),
                height: bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: bannerAd!),
              ),
            ),

          // LIST ARTIKEL
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredArticles.length,
              itemBuilder: (context, index) {
                final item = filteredArticles[index];
                return artikelTile(
                  item["tag"]!,
                  item["title"]!,
                  item["img"]!,
                  item["url"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // =================================================
  //                 ARTIKEL TILE WIDGET
  // =================================================
  Widget artikelTile(String tag, String title, String img, String url) {
    return GestureDetector(
      onTap: () => launchUrlString(url, mode: LaunchMode.externalApplication),
      child: Container(
        margin: const EdgeInsets.only(bottom: 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TEKS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TAG
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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

                  // JUDUL
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(width: 12),

            // GAMBAR
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                img,
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
