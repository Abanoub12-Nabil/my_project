import 'package:flutter/material.dart';
import 'package:Holy_Bible/custom_drawer.dart';
import 'custom_drawer.dart';
import 'old_testament_questions_page.dart';
import 'new_testament_questions_page.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      primaryColor: const Color(0xFFE67E22), // اللون البرتقالي
      hintColor: Colors.deepOrange,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.black,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          backgroundColor:
          const Color(0xFFE67E22), // تعيين لون البرتقالي للأزرار
          textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('الأسئلة'),
        backgroundColor: Colors.white
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/back.jpg',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          // الزر الأول: يدخل من اليمين
          Center(
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStyledButton(
                    context,
                    'أسئلة العهد القديم',
                    OldTestamentQuestionsPage(),
                  ),
                  const SizedBox(height: 20), // مسافة بين الأزرار
                  _buildStyledButton(
                    context,
                    'أسئلة العهد الجديد',
                    NewTestamentQuestionsPage(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledButton(BuildContext context, String text, Widget page) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        width: 220, // عرض الزر
        height: 70, // ارتفاع الزر
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [Colors.white, Colors.white30],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ElevatedButton.icon(
          icon: const SizedBox.shrink(), // إزالة الأيقونة أو جعلها غير مرئية
          label: Text(text),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
            shadowColor: Colors.black.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ).copyWith(
            shadowColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.blueGrey.withOpacity(0.8);
              }
              return Colors.blueGrey.withOpacity(0.5);
            }),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
        ),
      ),
    );
  }
}
