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
class  MainNavigation  extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CineBook 📚🎬', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.movie), text: "Movies"),
              Tab(icon: Icon(Icons.book), text: "Books"),
            ],
            indicatorColor: Colors.amber,
          ),
        ),
        body: const TabBarView(
          children: [
            ContentGrid(type: "Movie"),
            ContentGrid(type: "Book"),
          ],
        ),
      ),
    );
  }
}

// --- GRID TAMPILAN KONTEN ---
class ContentGrid extends StatelessWidget {
  final String type;
  const ContentGrid({super.key, required this.type});

  // Data Dummy untuk Movie & Book
  final List<Map<String, String>> data = const [
    {
      'title': 'The Batman',
      'image': '',
      'desc': 'Batman venture into Gotham City\'s underworld when a sadistic killer leaves behind a trail of cryptic clues.',
      'category': 'Movie'
    },
    {
      'title': 'Dune: Part Two',
      'image': '',
      'desc': 'Paul Atreides unites with Chani and the Fremen while on a warpath of revenge against the conspirators.',
      'category': 'Movie'
    },
    {
      'title': 'Atomic Habits',
      'image': '',
      'desc': 'An easy & proven way to build good habits and break bad ones by james clear.',
      'category': 'Book'
    },
    {
      'title': 'Harry Potter',
      'image': '',
      'desc': 'A young wizard discovers his madical heritage on his eleventh birthday.',
      'category': 'Book'
    },
  ];
  
}