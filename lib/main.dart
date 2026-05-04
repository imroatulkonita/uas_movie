import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- STATE MANAGEMENT (PROVIDER) ---
class FavoriteProvider extends ChangeNotifier {
  List<String> _favTitles = [];
  List<String> get favTitles => _favTitles;

  FavoriteProvider() { _loadFromPrefs(); }

  void _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _favTitles = prefs.getStringList('cinebook_favs') ?? [];
    notifyListeners();
  }

void toggleFavorite(String title) async {
  if (_favTitles.contains(title)) {
    _favTitles.remove(title);
  } else {
    _favTitles.add(title);
  }
  notifyListeners();
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList('cinebook_favs', _favTitles);
}

bool isFav(String title) => _favTitles.contains(title);
}

void main() {
  runApp(
    ChangeNotifierProvider(
     create: (context) => FavoriteProvider(),
     child: const CineBookApp(),
     ),
  );
}

class CineBookApp extends StatelessWidget {
  const CineBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineBook Directory',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
} 

const List<Map<String, String>> allData = [
  // --- KATALOG FILM ---
  {
    'title' : 'The Batman',
    'image' : 'https://m.media-amazon.com/images/I/81PWWFp26HL.jpg',
    'desc' : 'Batman venture inti Gotham City\'s underworld when a sadistic killer leaves behind cryptic clues.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Dune: Part Two',
    'image' : 'https://www.joblo.com/wp-content/uploads/2023/08/dune_part_two_empire_cover-791x1024.jpg',
    'desc' : 'Paul atreides unites with Chani and the Fremen while on a warpath of revenge.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Oppenheimer',
    'image' : 'https://www.tallengestore.com/cdn/shop/products/Oppenheimer-CillianMurphy-ChristopherNolan-HollywoodMoviePoster.jpg?v=1691369029',
    'desc' : 'Robert Oppenheimer and is role in the development of the atomic bomb.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Ayah, Ini Arahnya Kemana, ya?',
    'image' : 'https://m.media-amazon.com/images/M/MV5BMWY2MGIxMjctMWVkMy00NmNkLWI1ZjktMDM2YmI5ZmFmOWQ1XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
    'desc' : 'Sebuah perjalanan emosional seorang anak yang mencari jawaban dan arah hidup melalui kenangan serta sosok ayahnya.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Tunggu Aku Sukses Nanti',
    'image' : 'https://pbs.twimg.com/media/G9anVVJaYAMX4wV.jpg',
    'desc' : 'Perjuangan anak muda dalam meraih mimpi dan cinta, membuktikan bahwa sukses butuh proses dan kesabaran.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Alas Roban',
    'image' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5z86tlStLCvxuZBLWPj7yUMSl7Tw1-KiulA&s',
    'desc' : 'Mengambil latar di salah satu jalur paling angker di jawa tengah, film ini mengisahkan teror yang dialami sebuah keluarga saat terjebak di tengah hutn Alas Roban yang legendaris.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐',
  },
  {
    'title' : 'Kuyang',
    'image' : 'https://awsimages.detik.net.id/community/media/visual/2025/12/22/kuyank-1766410324112.jpeg?w=700&q=90',
    'desc' : 'Mengangkat legenda urban kalimantan tentang teror makhluk gaib berkepala tanpa tubuh. Sebuah kisah horor mencekam tentang perjuangan melawan kutukan kuno.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐',
  },
  {
    'title' : 'Perjalanan Pertama',
    'image' : 'https://akcdn.detik.net.id/visual/2022/06/30/akan-terjawab-kah-pertanyaan-tanfoto-hotdetikcomdetikhot_11.jpeg?w=480&q=90',
    'desc' : 'Sebuah film yang emosional antara seorang kakek dan cucunya. Di sepanjang jalan, mereka menemukan rahasia masa lalu dan belajar tentang arti keluarga serta kedewasaan serta kedewasaan melalui peristiwa-peristiwa tak terduga.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐',
  },
  {
    'title' : 'Satria Dewa: Gatotkaca',
    'image' : 'https://akcdn.detik.net.id/visual/2022/05/27/satria-dewa-gatotkacafoto-imdbcomimdb_11.jpeg?w=480&q=90',
    'desc' : 'Mengisahkan tentang pemuda yang menyadari bahwa ia memiliki garis keturunan pahlawan legendaris dan harus berjuang melindungi dunia dari ancaman kekuatan jahat  masa lalu.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐',
  },
  {
    'title' : 'Senin Harga Naik',
    'image' : 'https://cdn-jpr.jawapos.com/images/32/2026/01/23/WhatsApp-Image-2026-01-21-at-130826-1946617692.jpeg',
    'desc' : 'Film yang memotret realita kehidupan sosial dan ekonomi masyarakat dengan sentuhan darama yang kuat.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐',
  },

  // --- KATALOG BUKU ---
  {
    'title' : 'Atomic Habits',
    'image' : 'https://m.media-amazon.com/images/I/81YkqyaFVEL._AC_UF1000,1000_QL80_.jpg',
    'desc' : 'An easy & proven way to build goog habits and break bad ones.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'harry potter',
    'image' : 'https://m.media-amazon.com/images/I/71-++hbbERL.jpg',
    'desc' : 'A young wizard discovers his magical heritage on his eleventh birthday.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'The Midnight Library',
    'image' : 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1609973366i/56578056.jpg',
    'desc' : 'Di antara hidup dan mati ada sebuah perpustakaan yang berisi semua kemungkinan hidup yang bisa kita jalani.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'The Alchemist',
    'image' : 'https://m.media-amazon.com/images/S/compressed.photo.goodreads.com/books/1442866592i/9276509.jpg',
    'desc' : 'Perjalanan seorang pemuda mengejar mimpinya ke piramida mesir.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Rich Dad Poor Dad',
    'image' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCdyugC3G12f24SfC6wxeQINZEdsMIHMmj_g&s',
    'desc' : 'What the rich teach their kids about money that the poor and niddle class do not!.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Algorithms',
    'image' : 'https://ocw.mit.edu/courses/6-046j-introduction-to-algorithms-sma-5503-fall-2005/f79f55df6aae6289ed44a7170e19acd0_6-046jf05.jpg',
    'desc' : 'Materi fundamental tentang algoritma dan struktur data. Kunci utama untuk memecahkan masalah logika dan coding.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐',
  },
  {
    'title' : 'The Pragmatic Programmer',
    'image' : 'https://down-id.img.susercontent.com/file/ef1cc2323a14fc21179b884f56fc0e68',
    'desc' : 'Panduan menjadi pengembang software yang handal, mulai dari etika kerja hingga teknik coding yang efisien.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐',
  },
  {
    'title' : 'Mastering Python',
    'image' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrXvzfijI9usigxDv_Z_ekkS_TCFsWCZhVnycZLlBR0A&s',
    'desc' : 'Materi tingkat tingkat tinggi untuk menguasai fitur-fitur canggih python, optimasi code, dan pengembangan sistem skala besar.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐',
  },
  {
    'title' : 'Filosofi Teras',
    'image' : 'https://cdn-prd.tongkolspace.com/hipwee/wp-content/uploads/2024/05/hipwee-Filosofi-Teras-428x640.jpg',
    'desc' : 'Buku populer yang mengajarkan ajaran Stoisisme untuk membantu kita tetap tenang, tangguh, dan bahagia dalam menghadapi masalah hidup sehari-hari.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐',
  },
  {
    'title' : 'Logika Algoritma',
    'image' : 'https://bintangpusnas.perpusnas.go.id/api25/public/api/get-image/15376_prod_06f158a7899ea896d8cf2d0712a9bb05.png',
    'desc' : 'Panduan dasar pemrograman yang membahas cara berpikir sistematis dan logika penyelesaian masalah melalui algoritma yang efisien dan terstruktur.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐',
  },
];

// --- NAVIGATION UTAMA & SEARCH (TAB BAR) ---
class  MainNavigation  extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends
State<MainNavigation> {
  String search = "";

bool isLoading = true;

@override
void initState() {
  super.initState();
  Future.delayed(const Duration(milliseconds: 5000), () {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  });
}

  @override
  Widget build(BuildContext context) {
    String sapaan() {
      var jam = DateTime.now().hour;
      if (jam < 7) return 'Selamat Pagi';
      if (jam < 11) return 'Selamat Siang';
      if (jam < 18) return 'Selamat Sore';
      return 'Selamat Malam';
    }
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: const Text(
              'CineBook 📚🎬', 
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)
            )
          ),
          bottom : PreferredSize(
            preferredSize: const Size.fromHeight(110), 
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric
                (horizontal: 15),
                child: TextField( 
                  decoration: InputDecoration(
                    hintText: "Cari film atau buku...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    fillColor: Colors.white10,
                  ),
                  onChanged: (v) => setState(() => search = v.toLowerCase()),
                ),
              ),
              const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.movie), text: "Movies"),
              Tab(icon: Icon(Icons.book), text: "Books"),
              Tab(icon: Icon(Icons.favorite, color: Colors.amber,), text: "Favs"),
              ],
            indicatorColor: Colors.amber,
            ),
          ],
        ),
      ),
    ),

    body: isLoading
      ? Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${sapaan()}, Nita👋",
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 28, 
              fontWeight: FontWeight.bold
            ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.amber),
          ],
        ),
      )
      
        : TabBarView(
          children: [
        
            ContentGrid(type: "Movie", query: search),
            ContentGrid(type: "Book", query: search),
            const FavoriteScreen(),
          ],
        ),
        
      ),
    );
  }
}

// --- GRID TAMPILAN KONTEN ---
class ContentGrid extends StatelessWidget {
  final String type;
  final String query;
  const ContentGrid({super.key, required this.type, required this.query});


  @override
  Widget build(BuildContext context) {
    // FILTER BERDASARKAN TIPE DAN SEARCH QUERY
    final list = allData.where((i) => i['category'] == type 
    && i['title'] !.toLowerCase().contains(query)).toList();
    
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.6,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return GestureDetector(
            onTap: () =>
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => DetailPage(item: item))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(item['image']!, 
                      fit: BoxFit.cover, 
                      width: double.infinity),
                      ),
                    ),
                   
                    const SizedBox(height: 8),
                    Text(item['rating']!, style: const TextStyle(fontSize: 10)),
                    Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
                 ],
              ),
           );
        },
     );
  }
}

// --- HALAMAN DETAIL & FAVORITE BUTTOM ---
class DetailPage extends StatelessWidget {
  final Map<String, String> item;
  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<FavoriteProvider>(context);
    bool isFav = prov.isFav(item['title']!);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red: null),
          onPressed: () => prov.toggleFavorite (item['title']!),
          )
        ],
      ),
      body: Column(
          children: [
            Image.network(item['image']!, height: 350, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber)),
                  const SizedBox(height: 10),
                  Text(item['category']!, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 20),
                  const Text("Description:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(item['desc']!, style: const TextStyle(fontSize: 16, height: 1.5)),
                ],
              ),
            )
          ],
        ),
    );
  }
}

// --- FAVORITE LISH SCREEN ---
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<FavoriteProvider>(context);
    final favList = allData.where((i) => prov.favTitles.contains(i['title'])).toList();

    if (favList.isEmpty) return const Center(child: Text("Belum ada favorit ❤️"));

    return ListView.builder(
      itemCount: favList.length,
      itemBuilder: (context, index) {
        final item = favList[index];
        return ListTile(
          leading: Image.network(item['image']!, width: 50),
          title: Text(item['title']!),
          subtitle: Text(item['category']!),
          onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (c) => DetailPage(item: item))),
        );
      },
    );
  }
}