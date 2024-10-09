import 'package:flutter/material.dart';
import 'chapter_content_page.dart';

class BookPage extends StatelessWidget {
  final String testament;
  final String book;
  final int chaptersCount;

  const BookPage(this.testament, this.book, this.chaptersCount, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سفر $book'),
      ),
      body: ListView.builder(
        itemCount: chaptersCount,
        itemBuilder: (context, index) {
          int chapter = index + 1;
          return ListTile(
            title: Text('الأصحاح $chapter'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChapterContentPage(
                        testament: testament, book: book, chapter: chapter)),
              );
            },
          );
        },
      ),
    );
  }
}
