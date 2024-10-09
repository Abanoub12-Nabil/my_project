import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';
import 'old_testament_page.dart';
import 'new_testament_page.dart';
import 'custom_drawer.dart'; // تأكد من استيراد ملف custom_drawer.dart

class BiblePage extends StatefulWidget {
  const BiblePage({super.key});

  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('الكتاب المقدس'),
        backgroundColor:  Colors.white,
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          // تحسين عرض الصورة الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/back.jpg',
              fit: BoxFit.fill,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          // استخدام Column لتصميم منسق مع أزرار بتوزيع رأسي
          Center(
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStyledButton(
                    context,
                    'العهد القديم',
                    const OldTestamentPage(),
                    Icons.book,
                  ),
                  const SizedBox(height: 20), // مسافة بين الأزرار
                  _buildStyledButton(
                    context,
                    'العهد الجديد',
                    const NewTestamentPage(),
                    Icons.bookmark,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledButton(
      BuildContext context, String text, Widget page, IconData icon) {
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
          icon: Icon(icon, size: 28),
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
