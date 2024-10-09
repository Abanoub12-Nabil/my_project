import 'package:flutter/material.dart';
import 'bible_page.dart';
import 'notebook_page.dart';
import 'questions_page.dart';
import 'about_page.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            pinned: true,
            expandedHeight: 150.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'القائمة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  leading: Icon(Icons.book,
                      color: Theme.of(context).iconTheme.color),
                  title: const Text('الكتاب المقدس'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BiblePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.question_answer,
                      color: Theme.of(context).iconTheme.color),
                  title: const Text('الأسئلة'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuestionsPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.note,
                      color: Theme.of(context).iconTheme.color),
                  title: const Text('النوتة'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotebookPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info,
                      color: Theme.of(context).iconTheme.color),
                  title: const Text('نبذة عن التطبيق'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
