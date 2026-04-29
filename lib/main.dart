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

const List<Map<String, Sting>> allData = [
  // --- KATALOG FILM ---
  {
    'title' : 'The Batman',
    'image' : '',
    'desc' : 'Batman venture inti Gotham City\'s underworld when a sadistic killer leaves behind cryptic clues.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Dune: Part Two',
    'image' : '',
    'desc' : 'Paul atreides unites with Chani and the Fremen while on a warpath of revenge.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'The Batman',
    'image' : '',
    'desc' : 'Batman venture inti Gotham City\'s underworld when a sadistic killer leaves behind cryptic clues.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'The Batman',
    'image' : '',
    'desc' : 'Batman venture inti Gotham City\'s underworld when a sadistic killer leaves behind cryptic clues.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'The Batman',
    'image' : '',
    'desc' : 'Batman venture inti Gotham City\'s underworld when a sadistic killer leaves behind cryptic clues.',
    'category' : 'Movie',
    'rating' : '⭐⭐⭐⭐⭐'
  },

  // --- KATALOG BUKU ---
  {
    'title' : 'Atomic Habits',
    'image' : '',
    'desc' : 'An easy & proven way to build goog habits and break bad ones.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Atomic Habits',
    'image' : '',
    'desc' : 'An easy & proven way to build goog habits and break bad ones.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Atomic Habits',
    'image' : '',
    'desc' : 'An easy & proven way to build goog habits and break bad ones.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Atomic Habits',
    'image' : '',
    'desc' : 'An easy & proven way to build goog habits and break bad ones.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐'
  },
  {
    'title' : 'Atomic Habits',
    'image' : '',
    'desc' : 'An easy & proven way to build goog habits and break bad ones.',
    'category' : 'Book',
    'rating' : '⭐⭐⭐⭐⭐'
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
  String searchQuery = "";


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CineBook 📚🎬', style: TextStyle(fontWeight: FontWeight.bold)),
          bottom : PreferredSize(
            preferredSize: const Size.fromHeight(110), 
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.symmetric
                (horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Cari film atau buku...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    fillColor: Colors.white10,
                  ),
                  onChanged: (v) => setState(() => 
                  search = v.toLowerCase()),
                ),
              ),
              const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.movie), text: "Movies"),
              Tab(icon: Icon(Icons.book), text: "Books"),
              Tab(icon: Icon(Icons.favorite), text: "Favs"),
              ],
            indicatorColor: Colors.amber,
            ),
          ],
        ),
      ),
    ),
        body: TabBarView(
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