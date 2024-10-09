import 'package:flutter/material.dart';
import 'package:Holy_Bible/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chapters_data.dart';
import 'chapter_content_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق الكتاب المقدس',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Amiri', // استخدم خط عربي مناسب
      ),
      home: const NewTestamentPage(),
    );
  }
}

class NewTestamentPage extends StatelessWidget {
  const NewTestamentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('العهد الجديد'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesPage()),
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
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
      child: ListView.builder(
        itemCount: newTestamentBooks.length,
        itemBuilder: (context, index) {
          final book = newTestamentBooks[index];
          return ListTile(
            title: Text(book,
            style: const TextStyle(color: Colors.white), // تحديد لون الخط هنا,
            ),
            trailing: const Icon(Icons.book,color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChaptersListPage(
                    testament: 'العهد الجديد',
                    book: book,
                    chaptersCount: newTestamentChaptersCount[book]!,
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

class ChaptersListPage extends StatefulWidget {
  final String testament;
  final String book;
  final int chaptersCount;

  const ChaptersListPage({
    super.key,
    required this.testament,
    required this.book,
    required this.chaptersCount,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChaptersListPageState createState() => _ChaptersListPageState();
}

class _ChaptersListPageState extends State<ChaptersListPage> {
  String searchQuery = '';
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

  Future<void> _toggleFavorite(String chapter) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favorites.contains(chapter)) {
        favorites.remove(chapter);
      } else {
        favorites.add(chapter);
      }
      prefs.setStringList('favorites', favorites);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredChapters = List.generate(
      widget.chaptersCount,
          (index) => 'الإصحاح ${index + 1}',
    ).where((chapter) => chapter.contains(searchQuery)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book} - ${widget.testament}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ChapterSearchDelegate(
                  chapters: filteredChapters,
                  onQueryChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: filteredChapters.isNotEmpty
          ? ListView.separated(
        itemCount: filteredChapters.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final chapter = filteredChapters[index];
          final isFavorite =
          favorites.contains('${widget.book} - $chapter');
          return ListTile(
            title: Text(chapter),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () =>
                      _toggleFavorite('${widget.book} - $chapter'),
                ),
                const Icon(Icons.arrow_forward),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterContentPage(
                    testament: widget.testament,
                    book: widget.book,
                    chapter: index + 1,
                  ),
                ),
              );
            },
          );
        },
      )
          : const Center(child: Text('لا توجد فصول لعرضها')),
    );
  }
}

class ChapterSearchDelegate extends SearchDelegate<String> {
  final List<String> chapters;
  final ValueChanged<String> onQueryChanged;

  ChapterSearchDelegate({
    required this.chapters,
    required this.onQueryChanged,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          onQueryChanged(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
    chapters.where((chapter) => chapter.contains(query)).toList();
    return ListView(
      children: results.map((chapter) {
        return ListTile(
          title: Text(chapter),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChapterContentPage(
                  testament: 'العهد الجديد',
                  book: 'Book Name', // استبدل باسم الكتاب الفعلي
                  chapter: chapters.indexOf(chapter) + 1,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
    chapters.where((chapter) => chapter.contains(query)).toList();
    return ListView(
      children: suggestions.map((chapter) {
        return ListTile(
          title: Text(chapter),
          onTap: () {
            query = chapter;
            showResults(context);
          },
        );
      }).toList(),
    );
  }
}

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
      body: favorites.isEmpty
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
                    testament: 'العهد الجديد',
                    book: book,
                    chapter: int.parse(chapter.split(' ')[1]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
