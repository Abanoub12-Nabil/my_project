import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChapterQuestionsPage extends StatefulWidget {
  final String chapter;
  final List<Map<String, dynamic>> questions;

  const ChapterQuestionsPage({
    super.key,
    required this.chapter,
    required this.questions,
  });

  @override
  _ChapterQuestionsPageState createState() => _ChapterQuestionsPageState();
}

class _ChapterQuestionsPageState extends State<ChapterQuestionsPage> {
  Map<int, String> selectedChoices = {};
  Map<int, Color> choiceColors = {}; // لتخزين الألوان المرتبطة بالإجابات
  int currentQuestionIndex = 0;
  bool showCorrectAnswer = false;
  double _fontSize = 18.0;
  final Color _backgroundColor = Colors.white;
  int points = 0;
  Set<int> answeredQuestions = {}; // لتخزين فهارس الأسئلة التي تمت الإجابة عليها

  void goToNextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        showCorrectAnswer = false;
      });
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        showCorrectAnswer = false;
      });
    }
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
                value: _fontSize,
                min: 12.0,
                max: 40.0,
                divisions: 18,
                label: _fontSize.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() {
                    _fontSize = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  void _showResultAnimation(bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                isCorrect
                    ? 'assets/images/animations/Animation - 1724368816496.json'
                    : 'assets/images/animations/Animation - 1724369323574 sad.json',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 16.0),
              Text(
                isCorrect ? 'أحسنت! لقد حصلت على 5 نقاط.' : 'حاول مرة أخرى.',
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('حسنًا'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];
    final questionNumber = currentQuestionIndex + 1;
    final totalQuestions = widget.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('الأسئلة - الإصحاح ${widget.chapter}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_fields),
            onPressed: _showFontSizeDialog,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          image: DecorationImage(
            image: const AssetImage('assets/images/back.jpg'), // صورة الموبايل
            fit: BoxFit.cover, // لضبط الصورة على كامل الخلفية
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), // تغميق الصورة
              BlendMode.darken, // استخدام BlendMode لإضافة التأثير الداكن
            ),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'سؤال $questionNumber من $totalQuestions',
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            const SizedBox(height: 8.0),
            Text(
              question['question'],
              style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: question['choices'].map<Widget>((choice) {
                  bool isCorrect = choice == question['answer'];
                  bool isSelected =
                      selectedChoices[currentQuestionIndex] == choice;
                  Color choiceColor = isSelected
                      ? choiceColors[currentQuestionIndex] ?? Colors.white
                      : Colors.white;

                  return ListTile(
                    title: Text(
                      choice,
                      style: TextStyle(color: choiceColor, fontSize: _fontSize),
                    ),
                    selected: isSelected,
                    onTap: () {
                      if (!answeredQuestions.contains(currentQuestionIndex)) {
                        setState(() {
                          selectedChoices[currentQuestionIndex] = choice;
                          showCorrectAnswer = true;

                          if (isCorrect) {
                            points += 5;
                            choiceColors[currentQuestionIndex] = Colors.green;
                          } else {
                            choiceColors[currentQuestionIndex] = Colors.red;
                          }

                          answeredQuestions.add(currentQuestionIndex);
                        });

                        _showResultAnimation(isCorrect);
                      }
                    },
                  );
                }).toList(),
              ),
            ),
            if (showCorrectAnswer)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'الإجابة الصحيحة هي: ${question['answer']}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: _fontSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            Text(
              'نقاطك: $points',
              style: TextStyle(color: Colors.white, fontSize: _fontSize),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: goToPreviousQuestion,
                  child: const Text('السؤال السابق'),
                ),
                ElevatedButton(
                  onPressed: goToNextQuestion,
                  child: const Text('السؤال التالي'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
