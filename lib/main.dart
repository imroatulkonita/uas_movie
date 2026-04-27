import 'package:flutter/material.dart';

void main() {
  runApp(const CineBookApp());
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

// --- NAVIGATION UTAMA (TAB BAR) ---
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
          centerTitle: true,
          // FITUR SEARCH DI APPBAR
          bottom : PreferredSize(
            preferredSize: const Size.fromHeight(110), 
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 15,
                vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Cari film atau buku...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    contentPadding: const EdgeInsets.all(10),
                    fillColor: Colors.white10,
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
              const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.movie), text: "Movies"),
              Tab(icon: Icon(Icons.book), text: "Books"),
              ],
            indicatorColor: Colors.amber,
            ),
          ],
        ),
      ),
    ),
        body: TabBarView(
          children: [
        
            ContentGrid(type: "Movie", query: searchQuery),
            ContentGrid(type: "Book", query: searchQuery),
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

  // Data Dummy untuk Movie & Book
  final List<Map<String, String>> data = const [
    {
      'title': 'The Batman',
      'image': 'https://prodimage.images-bn.com/pimages/0883929728367_p0_v2_s600x595.jpg',
      'desc': 'Batman venture into Gotham City\'s underworld when a sadistic killer leaves behind a trail of cryptic clues.',
      'category': 'Movie'
    },
    {
      'title': 'Dune: Part Two',
      'image': 'https://www.joblo.com/wp-content/uploads/2023/08/dune_part_two_empire_cover-791x1024.jpg',
      'desc': 'Paul Atreides unites with Chani and the Fremen while on a warpath of revenge against the conspirators.',
      'category': 'Movie'
    },
    {
      'title': 'Atomic Habits',
      'image': 'https://image.gramedia.net/rs:fit:0:0/plain/https://cdn.gramedia.com/uploads/products/-omxcm6-m8.jpg',
      'desc': 'An easy & proven way to build good habits and break bad ones by james clear.',
      'category': 'Book'
    },
    {
      'title': 'Harry Potter',
      'image': 'https://static.republika.co.id/uploads/images/inline/sorcerers-stone-kazu-cover-full.jpg',
      'desc': 'A young wizard discovers his madical heritage on his eleventh birthday.',
      'category': 'Book'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // FILTER BERDASARKAN TIPE DAN SEARCH QUERY
    final filteredData = data.where((item) {
    return item['category'] == type && item['title']!.toLowerCase().contains(query);
    }).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.6,
        ),
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => DetailPage(item: filteredData[index]),
                  ),
                );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      filteredData[index] ['image'] !,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        filteredData[index] ['title'] !,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
               ),
            ),
         );
       },
    );
  }
}

// --- HALAMAN DETAIL ---
class DetailPage extends StatelessWidget {
  final Map<String, String> item;
  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item['title']!)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(item['image']!, width: double.infinity, height: 400, fit: BoxFit.cover),
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
            ),
          ],
        ),
      ),
    );
  }
}