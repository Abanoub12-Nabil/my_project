import 'package:flutter/material.dart';
import 'questions_data.dart';
import 'chapter_questions_page.dart'; // تأكد من استيراد الصفحة الجديدة

class ObadiahQuestionsPage extends StatefulWidget {
  const ObadiahQuestionsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ObadiahQuestionsPageState createState() => _ObadiahQuestionsPageState();
}

class _ObadiahQuestionsPageState extends State<ObadiahQuestionsPage> {
  String _searchQuery = '';
  double _selectedFontSize = 18.0; // حجم الخط الافتراضي

  @override
  Widget build(BuildContext context) {
    // تصفية الإصحاحات حسب نص البحث
    final filteredChapters = QuestionsData.obadiahQuestions.keys
        .where((chapter) => chapter.toString().contains(_searchQuery))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('أسئلة سفر عوبديا'),
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
                hintText: 'ابحث عن إصحاح...',
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
              QuestionsData.obadiahQuestions[chapter]?.length ??
                  0; // عدد الأسئلة
          return ListTile(
            tileColor: Colors.grey[200], // تغيير لون الخلفية
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
                        QuestionsData.obadiahQuestions[chapter]!,
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
