import 'package:flutter/material.dart';
import 'package:Holy_Bible/custom_drawer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chapter_content_page.dart';

class ChaptersPage extends StatefulWidget {
  final String book;
  final int chapters;

  const ChaptersPage({super.key, required this.book, required this.chapters});

  @override
  // ignore: library_private_types_in_public_api
  _ChaptersPageState createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  String searchQuery = '';
  Set<int> favoriteChapters = <int>{};
  bool showOnlyFavorites = false;
  String sortOrder = 'asc'; // 'asc' للترتيب التصاعدي، 'desc' للترتيب التنازلي

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteChapters = (prefs.getStringList('favorites') ?? [])
          .map((e) => int.parse(e))
          .toSet();
    });
  }

  void _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'favorites', favoriteChapters.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    // طباعة للتأكد من صحة القيم

    final allChapters = List.generate(
      widget.chapters,
          (index) => {
        'title': 'الأصحاح ${index + 1}',
        'details': 'تفاصيل حول الأصحاح ${index + 1}',
      },
    );

    final filteredChapters = allChapters.where((chapter) {
      final chapterTitle = chapter['title'];
      if (chapterTitle == null) return false;

      final chapterNumber = int.tryParse(chapterTitle.split(' ').last) ?? -1;
      final matchesSearch = chapterTitle.contains(searchQuery);
      final isFavorite = favoriteChapters.contains(chapterNumber);
      return matchesSearch && (!showOnlyFavorites || isFavorite);
    }).toList();

    filteredChapters.sort((a, b) {
      final aTitle = a['title'];
      final bTitle = b['title'];
      if (aTitle == null || bTitle == null) return 0;

      final aNumber = int.tryParse(aTitle.split(' ').last) ?? 0;
      final bNumber = int.tryParse(bTitle.split(' ').last) ?? 0;
      return sortOrder == 'asc'
          ? aNumber.compareTo(bNumber)
          : bNumber.compareTo(aNumber);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareBook,
          ),
          IconButton(
            icon: Icon(
                showOnlyFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                showOnlyFavorites = !showOnlyFavorites;
              });
            },
          ),
          IconButton(
            icon: Icon(
                sortOrder == 'asc' ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: () {
              setState(() {
                sortOrder = sortOrder == 'asc' ? 'desc' : 'asc';
              });
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ابحث عن أصحاح...',
              ),
            ),
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: ListView.builder(
        itemCount: filteredChapters.length,
        itemBuilder: (context, index) {
          final chapter = filteredChapters[index];
          final chapterTitle = chapter['title'];
          final chapterDetails = chapter['details'];
          if (chapterTitle == null || chapterDetails == null) {
            return const SizedBox.shrink();
          }

          final chapterNumber = int.tryParse(chapterTitle.split(' ').last) ?? 0;
          final isFavorite = favoriteChapters.contains(chapterNumber);

          return ListTile(
            title: Text(chapterTitle),
            subtitle: Text(chapterDetails),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    favoriteChapters.remove(chapterNumber);
                  } else {
                    favoriteChapters.add(chapterNumber);
                  }
                  _saveFavorites();
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterContentPage(
                    book: widget.book,
                    chapter: chapterNumber,
                    testament: '',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _shareBook() {
    final content =
        'Check out the book "${widget.book}" with ${widget.chapters} chapters!';
    Share.share(content);
  }
}
