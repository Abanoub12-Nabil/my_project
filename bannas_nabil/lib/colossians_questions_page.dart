import 'package:flutter/material.dart';
import 'questions_data.dart';
import 'chapter_questions_page.dart'; // تأكد من استيراد الصفحة الجديدة

class ColossiansQuestionsPage extends StatefulWidget {
  const ColossiansQuestionsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ColossiansQuestionsPageState createState() =>
      _ColossiansQuestionsPageState();
}

class _ColossiansQuestionsPageState extends State<ColossiansQuestionsPage> {
  String _searchQuery = '';
  double _selectedFontSize = 18.0; // حجم خط افتراضي

  @override
  Widget build(BuildContext context) {
    final filteredChapters =
    QuestionsData.colossiansQuestions.keys.where((chapter) {
      return chapter.toString().contains(_searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('أسئلة الرسالة إلي كولوسي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_fields),
            onPressed: () {
              _showFontSizeDialog();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'ابحث عن إصحاح بالرقم...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: filteredChapters.isEmpty
          ? const Center(child: Text('لا توجد نتائج تتطابق مع استعلام البحث.'))
          : ListView(
        padding: const EdgeInsets.all(8.0),
        children: filteredChapters.map((chapter) {
          final questionCount =
              QuestionsData.colossiansQuestions[chapter]?.length ?? 0;
          return ListTile(
            tileColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 16.0),
            title: Text(
              'الإصحاح $chapter ($questionCount سؤال)',
              style: TextStyle(
                fontSize: _selectedFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end);
                    var curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    );
                    var offsetAnimation = tween.animate(curvedAnimation);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: ChapterQuestionsPage(
                        chapter: chapter,
                        questions:
                        QuestionsData.colossiansQuestions[chapter]!,
                      ),
                    );
                  },
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تغيير حجم الخط'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('تغيير حجم الخط:'),
              Slider(
                value: _selectedFontSize,
                min: 12.0,
                max: 30.0,
                divisions: 18,
                label: _selectedFontSize.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() {
                    _selectedFontSize = value;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
