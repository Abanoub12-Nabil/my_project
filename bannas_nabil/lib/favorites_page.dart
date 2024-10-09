import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chapter_content_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> _removeFavorite(String chapter) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites.remove(chapter);
      prefs.setStringList('favorites', favorites);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/back.jpg'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), // اللون الذي تريده
              BlendMode.darken, // وضع المزج لدمج اللون مع الصورة
            ),
          ),
        ),
        child: favorites.isEmpty
            ? const Center(child: Text('لا توجد فصول مفضلة'))
            : ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final favorite = favorites[index];
            final parts = favorite.split(' - ');
            final book = parts[0];
            final chapter = parts[1];
            return ListTile(
              title: Text(favorite),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removeFavorite(favorite),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChapterContentPage(
                      testament: 'العهد القديم',
                      book: book,
                      chapter: int.parse(chapter.split(' ')[1]),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
