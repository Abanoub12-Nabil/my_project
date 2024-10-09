import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Holy_Bible/chapters_data.dart';
import 'package:Holy_Bible/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ChapterContentPage extends StatefulWidget {
  final String testament;
  final String book;
  int chapter;

  ChapterContentPage({
    super.key,
    required this.testament,
    required this.book,
    required this.chapter,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChapterContentPageState createState() => _ChapterContentPageState();
}

class _ChapterContentPageState extends State<ChapterContentPage> {
  double _fontSize = 16.0;
  String _fontFamily = 'Arial';
  Color _textColor = Colors.white;
  FontWeight _fontWeight = FontWeight.normal;
  final Color _selectedVerseColor = Colors.white;
  final Set<int> _selectedVerses = {};

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _loadUserSettings();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _saveUserSettings();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = widget.testament == 'العهد القديم'
        ? oldTestamentChaptersContent[widget.book]![widget.chapter]
        : newTestamentChaptersContent[widget.book]![widget.chapter];

    String chapterTitle = _getChapterTitle(widget.chapter);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book} - $chapterTitle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: _copySelectedVerses,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareSelectedVerses,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'fontFamily':
                  _showFontFamilyDialog();
                  break;
                case 'textColor':
                  _showTextColorDialog();
                  break;
                case 'textWeight':
                  _showTextWeightDialog();
                  break;
                case 'adjustFontSize':
                  _showFontSizeDialog();
                  break;
                case 'copyWholeChapter':
                  _copyWholeChapter();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'fontFamily',
                child: Text('تغيير نوع الخط'),
              ),
              const PopupMenuItem<String>(
                value: 'textColor',
                child: Text('تغيير لون النص'),
              ),
              const PopupMenuItem<String>(
                value: 'textWeight',
                child: Text('تغيير وزن النص'),
              ),
              const PopupMenuItem<String>(
                value: 'adjustFontSize',
                child: Text('تعديل حجم الخط'),
              ),
              const PopupMenuItem<String>(
                value: 'copyWholeChapter',
                child: Text('نسخ الأصحاح بالكامل'),
              ),
            ],
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
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: _buildVerses(content),
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  List<Widget> _buildVerses(String? content) {
    if (content == null || content.isEmpty) {
      return [const Text('محتوى غير متاح')];
    }

    final verses =
    content.split('\n').where((line) => line.trim().isNotEmpty).toList();

    return List.generate(verses.length, (index) {
      final verseNumber = index + 1;
      final verseText = verses[index];
      final isSelected = _selectedVerses.contains(verseNumber);
      return ListTile(
        tileColor: isSelected ? _selectedVerseColor : null,
        title: Text(
          '$verseNumber: $verseText',
          style: TextStyle(
            fontSize: _fontSize,
            fontFamily: _fontFamily,
            color: _textColor,
            fontWeight: _fontWeight,
          ),
        ),
        onTap: () {
          setState(() {
            if (_selectedVerses.contains(verseNumber)) {
              _selectedVerses.remove(verseNumber);
            } else {
              _selectedVerses.add(verseNumber);
            }
          });
        },
      );
    });
  }

  String _getChapterTitle(int chapterNumber) {
    const arabicNumbers = [
      'الأصحاح الأول',
      'الأصحاح الثاني',
      'الأصحاح الثالث',
      'الأصحاح الرابع',
      'الأصحاح الخامس',
      'الأصحاح السادس',
      'الأصحاح السابع',
      'الأصحاح الثامن',
      'الأصحاح التاسع',
      'الأصحاح العاشر',
      'الأصحاح الحادي عشر',
      'الأصحاح الثاني عشر',
      'الأصحاح الثالث عشر',
      'الأصحاح الرابع عشر',
      'الأصحاح الخامس عشر',
      'الأصحاح السادس عشر',
      'الأصحاح السابع عشر',
      'الأصحاح الثامن عشر',
      'الأصحاح التاسع عشر',
      'الأصحاح العشرون',
      'الأصحاح الواحد والعشرون',
      'الأصحاح الثاني والعشرون',
      'الأصحاح الثالث والعشرون',
      'الأصحاح الرابع والعشرون',
      'الأصحاح الخامس والعشرون',
      'الأصحاح السادس والعشرون',
      'الأصحاح السابع والعشرون',
      'الأصحاح الثامن والعشرون',
      'الأصحاح التاسع والعشرون',
      'الأصحاح الثلاثون',
      'الأصحاح الواحد والثلاثون',
      'الأصحاح الثاني والثلاثون',
      'الأصحاح الثالث والثلاثون',
      'الأصحاح الرابع والثلاثون',
      'الأصحاح الخامس والثلاثون',
      'الأصحاح السادس والثلاثون',
      'الأصحاح السابع والثلاثون',
      'الأصحاح الثامن والثلاثون',
      'الأصحاح التاسع والثلاثون',
      'الأصحاح الأربعون',
    ];

    if (chapterNumber > 0 && chapterNumber <= arabicNumbers.length) {
      return arabicNumbers[chapterNumber - 1];
    } else {
      return 'الأصحاح $chapterNumber';
    }
  }

  void _showFontFamilyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('اختر نوع الخط'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildFontFamilyOption('Arial'),
                _buildFontFamilyOption('Times New Roman'),
                _buildFontFamilyOption('Courier New'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFontFamilyOption(String fontFamily) {
    return RadioListTile<String>(
      title: Text(fontFamily),
      value: fontFamily,
      groupValue: _fontFamily,
      onChanged: (value) {
        setState(() {
          _fontFamily = value!;
        });
        Navigator.of(context).pop();
      },
    );
  }

  void _showTextColorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('اختر لون النص'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextColorOption(Colors.black, 'أسود'),
                _buildTextColorOption(Colors.red, 'أحمر'),
                _buildTextColorOption(Colors.blue, 'أزرق'),
                _buildTextColorOption(Colors.green, 'أخضر'),
                _buildTextColorOption(Colors.orange, 'برتقالي'),
                _buildTextColorOption(Colors.white, 'أبيض'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextColorOption(Color color, String label) {
    return ListTile(
      leading: Icon(
        Icons.circle,
        color: color,
      ),
      title: Text(label),
      onTap: () {
        setState(() {
          _textColor = color;
        });
        Navigator.of(context).pop();
      },
    );
  }

  void _showTextWeightDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('اختر وزن النص'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextWeightOption(FontWeight.normal, 'عادي'),
                _buildTextWeightOption(FontWeight.bold, 'عريض'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextWeightOption(FontWeight fontWeight, String label) {
    return RadioListTile<FontWeight>(
      title: Text(label),
      value: fontWeight,
      groupValue: _fontWeight,
      onChanged: (value) {
        setState(() {
          _fontWeight = value!;
        });
        Navigator.of(context).pop();
      },
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تعديل حجم الخط'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Slider(
                  value: _fontSize,
                  min: 10,
                  max: 40,
                  divisions: 20,
                  label: _fontSize.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _fontSize = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('حفظ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _copySelectedVerses() {
    if (_selectedVerses.isEmpty) return;

    final content = widget.testament == 'العهد القديم'
        ? oldTestamentChaptersContent[widget.book]![widget.chapter]
        : newTestamentChaptersContent[widget.book]![widget.chapter];

    final verses =
    content!.split('\n').where((line) => line.trim().isNotEmpty).toList();

    final selectedVersesText = _selectedVerses.map((verseNumber) {
      final verseText = verses[verseNumber - 1];
      return '$verseNumber: $verseText';
    }).join('\n');

    Clipboard.setData(ClipboardData(text: selectedVersesText));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم نسخ الآيات المحددة')),
    );
  }

  void _copyWholeChapter() {
    final content = widget.testament == 'العهد القديم'
        ? oldTestamentChaptersContent[widget.book]![widget.chapter]
        : newTestamentChaptersContent[widget.book]![widget.chapter];

    Clipboard.setData(ClipboardData(text: content!));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم نسخ محتوى الأصحاح بالكامل')),
    );
  }

  void _shareSelectedVerses() {
    if (_selectedVerses.isEmpty) return;

    final content = widget.testament == 'العهد القديم'
        ? oldTestamentChaptersContent[widget.book]![widget.chapter]
        : newTestamentChaptersContent[widget.book]![widget.chapter];

    final verses =
    content!.split('\n').where((line) => line.trim().isNotEmpty).toList();

    final selectedVersesText = _selectedVerses.map((verseNumber) {
      final verseText = verses[verseNumber - 1];
      return '$verseNumber: $verseText';
    }).join('\n');

    Share.share(selectedVersesText);
  }

  Future<void> _loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fontSize = prefs.getDouble('fontSize') ?? 16.0;
      _fontFamily = prefs.getString('fontFamily') ?? 'Arial';
      _textColor = Color(prefs.getInt('textColor') ?? Colors.white.value);
      _fontWeight = FontWeight.values[prefs.getInt('fontWeight') ?? 3];
    });
  }

  Future<void> _saveUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', _fontSize);
    await prefs.setString('fontFamily', _fontFamily);
    await prefs.setInt('textColor', _textColor.value);
    await prefs.setInt('fontWeight', _fontWeight.index);
  }
}